//
//  GalleryInteractor.swift
//  PhotoNet
//
//  Created by Aralbek Muhammed on 17.02.2022.
//

import Foundation

protocol GalleryInteractorProtocol: AnyObject{
    var presenter: GalleryPresenterProtocol! {get set}
    var photos: [UnsplashPhoto] {get set}
    
    func fetchNextItems()
    func collectionView(numberOfItemsInSection section: Int) -> Int
    func unsplashPhoto(for indexPath: IndexPath)->UnsplashPhoto
    func getSearchedPhotos(_ searchText: String)
    func getRandomPictures(completionHandler: (([UnsplashPhoto])->())?)
}
class GalleryInteractor: GalleryInteractorProtocol{
    
    var photos: [UnsplashPhoto] = []
    
    var currentPage = 1
    
    var searchText: String?
    
    func collectionView(numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func unsplashPhoto(for indexPath: IndexPath) -> UnsplashPhoto {
        return photos[indexPath.row]
    }
    
    func fetchNextItems() {
        currentPage += 1
        print("FETCHING PAGE: ", currentPage)
        if let searchText = searchText {
            UnsplashManager.getSearchResult(search: searchText, page: currentPage) { [weak self] photos in
                guard let self = self else{return}
                self.photos.append(contentsOf: photos ?? [])
                self.presenter.updateCollection(withNewItems: photos ?? [])
            }
        }else{
            UnsplashManager.getGallery(page: currentPage) { [weak self] photos in
                guard let self = self else{return}
                self.photos.append(contentsOf: photos ?? [])
                self.presenter.updateCollection(withNewItems: photos ?? [])
            }
        }
    }
    
    func getRandomPictures(completionHandler: (([UnsplashPhoto])->())?) {
        self.searchText = nil
        currentPage = 1
        self.photos = []
        self.presenter.updateCollection(withNewItems: [])
        UnsplashManager.getGallery(page: currentPage) { [weak self] photos in
            guard let self = self else{return}
            self.photos = photos ?? []
            self.presenter.updateCollection(withNewItems: photos ?? [])
            completionHandler?(self.photos)
        }
    }
    
    func getSearchedPhotos(_ searchText: String){
        self.searchText = searchText
        currentPage = 1
        photos = []
        self.presenter.updateCollection(withNewItems: [])
        UnsplashManager.getSearchResult(search: searchText, page: currentPage) { [weak self] photos in
            guard let self = self else{return}
            self.photos = photos ?? []
            self.presenter.updateCollection(withNewItems: photos ?? [])
        }
    }
    
    weak var presenter: GalleryPresenterProtocol!
}
