import UIKit
extension GalleryView{
    func configureView(){
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchTF)
        searchTF.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchTF.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            searchTF.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25),
            searchTF.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25),
            searchTF.heightAnchor.constraint(equalToConstant: 35),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
