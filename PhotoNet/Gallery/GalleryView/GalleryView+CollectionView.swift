import UIKit
extension GalleryView: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.collectionView(numberOfItemsInSection: section)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCVC", for: indexPath) as? PhotoCVC else{fatalError()}
        let unsplashPhoto = presenter.unsplashPhoto(for: indexPath)
        cell.configure(with: unsplashPhoto, shouldShowAutorLabel: false)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.collectionView(didSelectItemAt: indexPath)
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        presenter.willDisplayCell(at: indexPath)
    }
}
