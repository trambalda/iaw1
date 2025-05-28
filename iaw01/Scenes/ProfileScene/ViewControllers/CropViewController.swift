import UIKit

final class CropViewController: UIViewController {
    
    private var cropAreaLeadingConstraint: NSLayoutConstraint!
    private var cropAreaTopConstraint: NSLayoutConstraint!
    
    private let image: UIImage
    private let completion: (UIImage) -> Void
    private let cropSize: CGFloat = 150

    private let overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.90)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = false
        return view
    }()
    
    private lazy var cropAreaView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        view.addGestureRecognizer(panGesture)
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private lazy var cropButton: UIButton = {
        let button = UIButton()
        button.setTitle("Done", for: .normal)
        button.addTarget(self, action: #selector(cropTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateOverlay()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        setupLayout()
        setupConstraints()
    }
    
    init(image: UIImage, completion: @escaping (UIImage) -> Void) {
        self.image = image
        self.completion = completion
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        view.addSubview(imageView)
        view.addSubview(overlayView)
        view.addSubview(cropAreaView)
        view.addSubview(cropButton)
        view.addSubview(cancelButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            cropButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            cropButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            cropButton.heightAnchor.constraint(equalToConstant: 40),
            cropButton.widthAnchor.constraint(equalToConstant: 100),
            
            cancelButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            cancelButton.heightAnchor.constraint(equalToConstant: 40),
            cancelButton.widthAnchor.constraint(equalToConstant: 100),
            
            overlayView.topAnchor.constraint(equalTo: view.topAnchor),
            overlayView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            overlayView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            cropAreaView.widthAnchor.constraint(equalToConstant: cropSize),
            cropAreaView.heightAnchor.constraint(equalToConstant: cropSize),
        ])
        
        cropAreaLeadingConstraint = cropAreaView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: (view.bounds.width - cropSize) / 2)
        cropAreaTopConstraint = cropAreaView.topAnchor.constraint(equalTo: view.topAnchor, constant: (view.bounds.height - cropSize) / 2)
        
        NSLayoutConstraint.activate([
            cropAreaLeadingConstraint,
            cropAreaTopConstraint
        ])
    }
    
    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        
        var newLeading = cropAreaLeadingConstraint.constant + translation.x
        var newTop = cropAreaTopConstraint.constant + translation.y
        
        guard let imageFrame = imageViewFrameInViewCoordinates() else { return }
        
        let minLeading = imageFrame.minX
        let maxLeading = imageFrame.maxX - cropSize
        let minTop = imageFrame.minY
        let maxTop = imageFrame.maxY - cropSize
        
        newLeading = max(minLeading, min(newLeading, maxLeading))
        newTop = max(minTop, min(newTop, maxTop))
        
        cropAreaLeadingConstraint.constant = newLeading
        cropAreaTopConstraint.constant = newTop
        
        gesture.setTranslation(.zero, in: view)
        
        UIView.animate(withDuration: 0.01) {
            self.view.layoutIfNeeded()
        }
        
        updateOverlay()
    }
    
    private func updateOverlay() {
        let path = UIBezierPath(rect: view.bounds)
        let cropRect = cropAreaView.frame
        path.append(UIBezierPath(rect: cropRect).reversing())
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        overlayView.layer.mask = maskLayer
    }
    
    @objc private func cropTapped() {
        guard let croppedImage = cropImage() else { return }
        completion(croppedImage)
        dismiss(animated: true)
    }
    
    @objc private func cancelTapped() {
        dismiss(animated: true)
    }
    
    private func cropImage() -> UIImage? {
        guard let image = imageView.image else { return nil }
        
        guard let imageFrame = imageViewFrameInViewCoordinates() else { return nil }
        
        let imageSize = image.size
        
        let scaleX = imageSize.width / imageFrame.width
        let scaleY = imageSize.height / imageFrame.height
        
        let cropFrame = cropAreaView.frame
        
        let cropOriginInImageView = CGPoint(
            x: cropFrame.origin.x - imageFrame.origin.x,
            y: cropFrame.origin.y - imageFrame.origin.y
        )
        
        let cropRect = CGRect(
            x: cropOriginInImageView.x * scaleX,
            y: cropOriginInImageView.y * scaleY,
            width: cropFrame.size.width * scaleX,
            height: cropFrame.size.height * scaleY
        ).integral
        
        guard let cgImage = image.cgImage?.cropping(to: cropRect) else { return nil }
        return UIImage(cgImage: cgImage, scale: image.scale, orientation: image.imageOrientation)
    }
    
    private func imageViewFrameInViewCoordinates() -> CGRect? {
        guard let image = imageView.image else { return nil }
        
        let imageRatio = image.size.width / image.size.height
        let viewRatio = imageView.bounds.width / imageView.bounds.height
        
        var width: CGFloat
        var height: CGFloat
        
        if imageRatio > viewRatio {
            width = imageView.bounds.width
            height = width / imageRatio
        } else {
            height = imageView.bounds.height
            width = height * imageRatio
        }
        
        let x = (imageView.bounds.width - width) / 2 + imageView.frame.origin.x
        let y = (imageView.bounds.height - height) / 2 + imageView.frame.origin.y
        
        return CGRect(x: x, y: y, width: width, height: height)
    }
}
