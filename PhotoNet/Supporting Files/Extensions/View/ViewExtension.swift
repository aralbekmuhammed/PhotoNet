import UIKit
extension UIView {
    /// Rounds corner radius of view
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: 0.0))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    /// Circles View
    func circle(){
        layer.cornerRadius = frame.height / 2
    }
    /// Sets border to view
    func setBorder(color: UIColor, width: CGFloat){
        layer.borderColor = color.cgColor
        layer.borderWidth = width
    }
    func removeSubviews(){
        subviews.forEach {
            $0.removeFromSuperview()
        }
    }
    func removeGestureRecognizers(){
        gestureRecognizers?.removeAll()
    }
    /// Drops shadow to view
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: layer.cornerRadius).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
extension UIImageView{
    func changeImageWithAnimation(toImage image: UIImage, duration: CFTimeInterval){
        let animation = CABasicAnimation(keyPath: "contents")
        animation.fromValue = self.image
        animation.toValue = image
        animation.duration = duration
        layer.add(animation, forKey: "contents")
        self.image = image
    }
}
