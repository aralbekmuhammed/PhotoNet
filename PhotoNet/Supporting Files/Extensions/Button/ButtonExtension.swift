import UIKit
extension UIButton {
    func setState(_ state: ButtonState, backgroundColor: UIColor? = nil, textColor: UIColor? = nil){
        switch state{
        case .enabled:
            self.isEnabled = true
        case .disabled:
            self.isEnabled = false
        }
        if let backgroundColor = backgroundColor {
            self.backgroundColor = backgroundColor
        }
        if let textColor = textColor {
            self.setTitleColor(textColor, for: .normal)
        }
    }
    func adjustTitleToFitWidth(){
        titleLabel?.adjustsFontSizeToFitWidth = true
    }
}
