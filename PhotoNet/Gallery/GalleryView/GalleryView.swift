//
//  GalleryView.swift
//  PhotoNet
//
//  Created by Aralbek Muhammed on 17.02.2022.
//

import UIKit

protocol GalleryViewProtocol: UIViewController{
    var presenter: GalleryPresenterProtocol! {get set}
    var configurator: GalleryConfiguratorProtocol {get}
    var searchTF: UISearchTextField{get set}
    var collectionView: UICollectionView{get set}
    
    func configureView()
    func dismissRefreshControl()
    func setSearchTFText(to text: String?)
}
class GalleryView: UIViewController, GalleryViewProtocol{
    var presenter: GalleryPresenterProtocol!
    var configurator: GalleryConfiguratorProtocol = GalleryConfigurator()

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero,collectionViewLayout: layout)
        cv.delegate = self
        cv.addRefreshControl(selector: #selector(didPullCollectionView))
        cv.dataSource = self
        cv.keyboardDismissMode = .interactive
        cv.register(PhotoCVC.self, forCellWithReuseIdentifier: "PhotoCVC")
        return cv
    }()
    
    lazy var searchTF: UISearchTextField = {
        let tf = UISearchTextField()
        tf.delegate = self
        tf.placeholder = "Search photo"
        tf.backgroundColor = .white
        return tf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(vc: self)
        presenter.configureView()
    }
        
    @objc func didPullCollectionView(){
        presenter.collectionViewDidPull()
    }
    
    func setSearchTFText(to text: String?) {
        searchTF.text = text
    }
    
    func dismissRefreshControl() {
        collectionView.refreshControl?.endRefreshing()
    }
}
