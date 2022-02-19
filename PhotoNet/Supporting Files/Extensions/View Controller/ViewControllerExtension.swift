import UIKit
import StoreKit
import SafariServices
import AVFoundation
import AVKit
import JGProgressHUD
import Then
let spinner = JGProgressHUD(style: .dark)
struct AlertAction{
    let text: String
    let type: UIAlertAction.Style
    var action: ((UIAlertAction) -> Void)? = nil
}
enum NavigationBarEdge{
    case left,right
}
func takeScreenshot(_ shouldSave: Bool = true) -> UIImage? {
    var screenshotImage :UIImage?
    let layer = UIApplication.shared.keyWindow!.layer
    let scale = UIScreen.main.scale
    UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale);
    guard let context = UIGraphicsGetCurrentContext() else {return nil}
    layer.render(in:context)
    screenshotImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return screenshotImage
}
extension UIViewController {
    //MARK: - Navigation Bar
    func setNavBar(cornerRadius: CGFloat,
                   color: UIColor){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.isTranslucent = true
        let navBarView = UIView(frame: CGRect(x: 0,
                                              y: 0,
                                              width: UIScreen.main.bounds.width,
                                              height: navBarHeight))
        navBarView.do {
            $0.roundCorners(corners: [.bottomRight, .bottomLeft], radius: cornerRadius)
            $0.backgroundColor = color
        }
        self.view.addSubview(navBarView)
    }
    
    var navBarHeight: CGFloat{
        UIApplication.shared.statusBarFrame.size.height +
        (self.navigationController?.navigationBar.frame.height ?? 0.0)
        
    }
    func addButton(to edge: NavigationBarEdge,
                   withImage image: UIImage? = nil,
                   spacing: CGFloat = .zero,
                   title: String? = nil,
                   titleColor: UIColor? = nil,
                   titleFont: UIFont = .systemFont(ofSize: 18),
                   contentInset: UIEdgeInsets = .zero,
                   selector: Selector){
        let button = UIButton().then {
            //MARK: - TITLE
            $0.setTitle(title,
                        for: .normal)
            $0.setTitleColor(titleColor,
                             for: .normal)
            $0.titleLabel?.font = titleFont
            $0.titleLabel?.sizeToFit()
            if let titleLabel = $0.titleLabel{
                titleLabel.widthAnchor.constraint(equalToConstant: titleLabel.frame.width).isActive = true
            }
            //MARK: - INSET
            if let _ = image,
               let _ = title{
                $0.titleEdgeInsets.left = spacing
            }
            $0.contentEdgeInsets = contentInset
            if edge == .right{
                let right = contentInset.right
                $0.contentEdgeInsets.right = contentInset.left
                $0.contentEdgeInsets.left = right
            }
            //MARK: - IMAGE
            $0.setImage(image, for: .normal)
            $0.imageView?.contentMode = .scaleAspectFit
            //MARK: - Transforming
            if edge == .right{
                $0.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
                $0.titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
                $0.imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
            }
            //MARK: - TARGET
            $0.addTarget(self,
                         action: selector,
                         for: .touchUpInside)
        }
        let buttonItem = UIBarButtonItem(customView: button)
        switch edge {
        case .left:
            navigationItem.leftBarButtonItems = [buttonItem]
        case .right:
            navigationItem.rightBarButtonItems = [buttonItem]
        }
    }
    func presentRateAlert(){
        guard let window = view.window,
              let scene = window.windowScene else{return}
        if #available(iOS 14.0, *) {
            SKStoreReviewController.requestReview(in: scene)
        } else {
            SKStoreReviewController.requestReview()
        }
    }
    
    func openWebsite(_ string: String){
        guard let url = URL(string: string) else{return}
        present(SFSafariViewController(url: url),
                animated: true)
        
    }
    
    func openVideo(from url: URL){
        let player = AVPlayer(url: url)
        let playerController = AVPlayerViewController().then {
            $0.player = player
        }
        present(playerController, animated: true) {
            player.play()
        }
    }
    
    func callToPhoneNumber(_ phoneNumber: String){
        guard let number = URL(string: "tel://" + phoneNumber) else {print("looks like it's something wrong with phone number"); return }
        UIApplication.shared.open(number)
    }
    
    func showAlert(withTitle: String?,
                   message: String?,
                   alpha: CGFloat = 1,
                   style: UIAlertController.Style = .alert,
                   actions: [AlertAction] = [AlertAction(text: "Ок", type: .default)]){
        let alert = UIAlertController(title: withTitle, message: message, preferredStyle: style)
        alert.view.alpha = alpha
        actions.forEach { action in
            alert.addAction(UIAlertAction(title: action.text, style: action.type, handler: action.action))
        }
        present(alert, animated: true, completion: nil)
    }
    
    func presentViewController(viewController: UIViewController,
                               presentationStyle: UIModalPresentationStyle,
                               transitionStyle: UIModalTransitionStyle,
                               animated: Bool){
        viewController.modalPresentationStyle = presentationStyle
        viewController.modalTransitionStyle = transitionStyle
        present(viewController, animated: animated)
    }
}

