//
//  GalleryPresenter.swift
//  PhotoNet
//
//  Created by Aralbek Muhammed on 17.02.2022.
//

import Foundation
import UIKit

protocol GalleryPresenterProtocol: AnyObject{
    var view: GalleryViewProtocol! {get set}
    var interactor: GalleryInteractorProtocol! {get set}
    var router: GalleryRouterProtocol! {get set}
    
    func willDisplayCell(at indexPath: IndexPath)
    func didTapSearch(with text: String?)
    func unsplashPhoto(for indexPath: IndexPath)->UnsplashPhoto
    func configureView()
    func collectionView(numberOfItemsInSection section: Int) -> Int
    func collectionView(didSelectItemAt indexPath: IndexPath)
    func updateCollection(withNewItems newItems: [UnsplashPhoto])
}
class GalleryPresenter: GalleryPresenterProtocol{
    func unsplashPhoto(for indexPath: IndexPath) -> UnsplashPhoto {
        interactor.unsplashPhoto(for: indexPath)
    }
    
    func collectionView(numberOfItemsInSection section: Int) -> Int {
        interactor.collectionView(numberOfItemsInSection: section)
    }
    
    func updateCollection(withNewItems newItems: [UnsplashPhoto]) {
        let newPhotosCount = newItems.count
        let startIndex = interactor.photos.count - newPhotosCount
        let endIndex = startIndex + newPhotosCount
        var newIndexPaths = [IndexPath]()
        for index in startIndex..<endIndex {
            newIndexPaths.append(IndexPath(item: index, section: 0))
        }
        view.collectionView.insertItems(at: newIndexPaths)
    }
    
    func collectionView(didSelectItemAt indexPath: IndexPath) {
        let selectedPhoto = interactor.unsplashPhoto(for: indexPath)
        let aboutVC = AboutView(id: selectedPhoto.id)
        router.presentAboutVC(aboutVC)
    }
    
    func didTapSearch(with text: String?) {
        if let text = text {
            interactor.getSearchedPhotos(text)
        }else{
            interactor.getRandomPictures()
        }
    }
    
    func willDisplayCell(at indexPath: IndexPath) {
        let prefetchCount = 5
        if indexPath.item == interactor.photos.count - prefetchCount {
            interactor.fetchNextItems()
        }
    }
    
    weak var view: GalleryViewProtocol!
    
    var interactor: GalleryInteractorProtocol!
    
    var router: GalleryRouterProtocol!
    
    func configureView() {
        view.configureView()
        interactor.getRandomPictures()
    }
}
