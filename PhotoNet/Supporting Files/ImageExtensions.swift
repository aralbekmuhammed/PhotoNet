import UIKit
extension UIImageView {
    func setImageByURL(_ url: String) {
        self.image = nil
        guard let url = URL(string: url) else{self.image = nil;return}
        URLSession.shared.dataTask(with: url, completionHandler: { (data, _, _) in
            DispatchQueue.main.async {
                guard let data = data,
                      let downloadedImage = UIImage(data: data) else{self.image = nil; return}
                self.image = downloadedImage
            }
        }).resume()
    }
}
