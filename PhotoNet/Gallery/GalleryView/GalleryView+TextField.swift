import UIKit
extension GalleryView: UISearchTextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        presenter.didTapSearch(with: textField.text)
        return true
    }
}
