import UIKit
extension GalleryView: UISearchTextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let text = textField.text{
            presenter.didTapSearch(with: text)
        }
        return true
    }
}
