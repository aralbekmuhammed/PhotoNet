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
    
    func collectionViewDidPull()
    func willDisplayCell(at indexPath: IndexPath)
    func didTapSearch(with text: String)
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
        spinner.dismiss()
        
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
    
    func didTapSearch(with text: String) {
        spinner.show(in: view.view)
        if !text.isEmpty {
            interactor.getSearchedPhotos(text)
        }else{
            interactor.getRandomPictures(completionHandler: nil)
        }
    }
    
    func collectionViewDidPull() {
        interactor.getRandomPictures { [weak self] _ in
            guard let self = self else{return}
            self.view.dismissRefreshControl()
            self.view.setSearchTFText(to: nil)
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
        spinner.show(in: view.view)
        interactor.getRandomPictures(completionHandler: nil)
    }
}
