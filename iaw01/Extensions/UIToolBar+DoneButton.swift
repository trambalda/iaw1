import UIKit

extension UIToolbar {
    static func doneToolbar(target: Any?, action: Selector?) -> UIToolbar {
        let screenWidth = UIScreen.main.bounds.width
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 44))
        toolbar.autoresizingMask = .flexibleWidth

        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: target, action: action)

        toolbar.setItems([flexibleSpace, doneButton], animated: false)
        return toolbar
    }
}
