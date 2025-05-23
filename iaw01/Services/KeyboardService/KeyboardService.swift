import UIKit

protocol KeyboardServiceProtocol: AnyObject {
    var isEnabled: Bool { get set }
}

final class KeyboardService: KeyboardServiceProtocol {

    var isEnabled: Bool = false {
        didSet {
            isEnabled ? setupKeyboardNotifications() : removeKeyboardNotifications()
        }
    }

    private weak var activeTextField: UITextField?
    private weak var activeScrollView: UIScrollView?
    private var debounceTimer: Timer?

    private let spacing: CGFloat = 20
    private var lastOffset: CGFloat = 0.0
    private var originalInset: UIEdgeInsets = .zero
    private var originalOffset: CGPoint = .zero

    private lazy var tapGesture: UITapGestureRecognizer = {
        let gesture  = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard)
        )
        gesture.cancelsTouchesInView = false
        return gesture
    }()

    init() {
        setupGesture()

        if isEnabled {
            setupKeyboardNotifications()
        }
    }

    deinit {
        removeKeyboardNotifications()
        removeGesture()
    }

        //    MARK: - Setup Notification
    private func setupKeyboardNotifications() {
        removeKeyboardNotifications()
        NotificationCenter.registerKeyboardNotifications(
            self,
            willShowSelector: #selector(keyboardWillShow(notification:)),
            willHideSelector: #selector(keyboardWillHide(notification:))
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(textFieldDidBeginEditing(notification:)),
            name: UITextField.textDidBeginEditingNotification,
            object: nil
        )
    }

    private func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self)
    }

        //    MARK: - Notification Actions
    @objc private func textFieldDidBeginEditing(notification: Notification) {
        guard let textField = notification.object as? UITextField else { return }
        activeTextField = textField
    }

    @objc private func keyboardWillShow(notification: Notification) {
        guard
            let userInfo = notification.userInfo,
            let keyboardFrameValue = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
            let animationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval,
            let animationOption = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt,
            let rootViewController = UIApplication.rootViewController?.topMostViewController(),
            let activeResponder = activeTextField
        else { return }

        let option = UIView.AnimationOptions(rawValue: animationOption << 16)
        activeScrollView = findParentScrollView(for: activeResponder)

        debounceTimer?.invalidate()

        debounceTimer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: false) { [weak self] _ in
            self?.handleView(
                rootViewController: rootViewController.view,
                activeView: activeResponder,
                scrollView: self?.activeScrollView ?? UIScrollView(),
                keyboardHeight: keyboardFrameValue.height,
                duration: animationDuration,
                options: option
            )
        }
    }

    private func handleView(
        rootViewController: UIView,
        activeView: UIView,
        scrollView: UIScrollView,
        keyboardHeight: CGFloat,
        duration: TimeInterval,
        options: UIView.AnimationOptions
    ) {
        if let scrollView = activeScrollView {
            scrollView.contentInsetAdjustmentBehavior = .never
            let (offset, inset) = calculateScrollViewOffset(
                rootViewController: rootViewController,
                activeView: activeView,
                scrollView: scrollView,
                keyboardHeight: keyboardHeight
            )
            print("ScrollView Offset:", offset, "Inset:", inset)
            guard (offset, inset) != (scrollView.contentOffset, scrollView.contentInset) else { return }

            adjustScrollView(
                scrollView: scrollView,
                offset: offset,
                inset: inset,
                duration: duration,
                options: options
            )
        } else {
            let offset = calculateViewOffset(
                activeView: activeView,
                rootViewController: rootViewController,
                keyboardHeight: keyboardHeight
            )

            print("View Offset:", offset)

            guard lastOffset != offset else { return }
            lastOffset = offset

            adjustView(
                containerView: rootViewController,
                duration: duration,
                offset: offset,
                options: options
            )
        }
    }

    @objc private func keyboardWillHide(notification: Notification) {
        guard let userInfo = notification.userInfo,
              let animationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval,
              let rootViewController = UIApplication.rootViewController?.topMostViewController()
        else { return }

        if let scrollView = activeScrollView {
            scrollView.contentInsetAdjustmentBehavior = .automatic
            restoreScrollViews(duration: animationDuration, scrollView: scrollView)
        } else {
            restoreView(currentViewController: rootViewController, duration: animationDuration)
        }
    }

    @objc private func dismissKeyboard() {
        UIApplication.keyWindowIsConnectedScenes?.endEditing(true)
        activeScrollView = nil
        activeTextField = nil
    }

        //    MARK: - Calculate Offset
    private func calculateViewOffset(
        activeView: UIView,
        rootViewController: UIView,
        keyboardHeight: CGFloat
    ) -> CGFloat {
        let activeRect = activeView.convert(activeView.bounds, to: rootViewController)
        let safeAreaBottom = rootViewController.safeAreaInsets.bottom

        let keyboardOffset = rootViewController.bounds.height - keyboardHeight - spacing
        let availableHeight = keyboardOffset - safeAreaBottom
        let offset = max(0, activeRect.maxY - availableHeight)

        return offset
    }

    private func calculateScrollViewOffset(
        rootViewController: UIView,
        activeView: UIView,
        scrollView: UIScrollView,
        keyboardHeight: CGFloat
    ) -> (CGPoint, UIEdgeInsets) {

        let activeRect = activeView.convert(activeView.bounds, to: scrollView)
        let scrollViewFrame = scrollView.convert(scrollView.bounds, to: rootViewController)
        let visibleHeight = (rootViewController.bounds.height - keyboardHeight) - scrollViewFrame.minY
        let contentOffsetY = max(0, activeRect.maxY - visibleHeight + spacing)
        let bottomInset = keyboardHeight - (rootViewController.bounds.height - scrollViewFrame.maxY)

        let offsets = CGPoint(x: scrollView.contentOffset.x, y: contentOffsetY)
        let insets = UIEdgeInsets(
            top: scrollView.contentInset.top,
            left: scrollView.contentInset.left,
            bottom: max(bottomInset, 0),
            right: scrollView.contentInset.right
        )

        return (offsets, insets)
    }

        //    MARK: - Adjust and restore views
    private func adjustView(
        containerView: UIView,
        duration: TimeInterval,
        offset: CGFloat,
        options: UIView.AnimationOptions
    ) {
        let transform = CGAffineTransform(translationX: 0, y: -offset)

        UIView.animate(
            withDuration: duration + 0.25,
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 0.8,
            options: [options, .beginFromCurrentState]
        ) {
            containerView.transform = transform
        }
    }

    private func adjustScrollView(
        scrollView: UIScrollView,
        offset: CGPoint,
        inset: UIEdgeInsets,
        duration: TimeInterval,
        options: UIView.AnimationOptions
    ) {

        UIView.animate(
            withDuration: duration,
            delay: 0,
            options: options
        ) {
            scrollView.contentInset = inset
            scrollView.scrollIndicatorInsets = inset
            scrollView.contentOffset = offset
        } completion: { _ in
            scrollView.layoutIfNeeded()
        }
    }

    private func restoreView(currentViewController: UIViewController, duration: TimeInterval) {
        UIView.animate(
            withDuration: duration + 0.2,
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 0.9,
            options: [.curveEaseInOut, .beginFromCurrentState]
        ) {
            currentViewController.view.transform = .identity

        } completion: { [weak self] _ in
            self?.activeTextField = nil
            self?.lastOffset = .zero
        }
    }

    private func restoreScrollViews(duration: TimeInterval, scrollView: UIScrollView) {
        UIView.animate(withDuration: duration, delay: 0, options: [.curveEaseInOut]) {
            scrollView.contentInset = self.originalInset
            scrollView.scrollIndicatorInsets = self.originalInset
            scrollView.contentOffset = self.originalOffset
            scrollView.layoutIfNeeded()

        } completion: { [weak self] _ in
            self?.activeScrollView = nil
        }
    }
}

    //    MARK: - Find Responder
extension KeyboardService {
    private func findParentScrollView(for view: UIView) -> UIScrollView? {
        var parent = view.superview
        while let current = parent {
            if let scrollView = current as? UIScrollView, scrollView.isScrollEnabled {
                return scrollView
            }
            parent = current.superview
        }
        return nil
    }
}

    //    MARK: - Setup Gesture
extension KeyboardService {
    private func setupGesture() {
        guard let window = UIApplication.keyWindowIsConnectedScenes else { return }
        window.addGestureRecognizer(tapGesture)
    }

    private func removeGesture() {
        guard let window = UIApplication.keyWindowIsConnectedScenes else { return }
        window.removeGestureRecognizer(tapGesture)
    }
}
