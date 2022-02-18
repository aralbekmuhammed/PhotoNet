//
//  FavouritesInteractor.swift
//  PhotoNet
//
//  Created by Aralbek Muhammed on 17.02.2022.
//

import Foundation

protocol FavouritesInteractorProtocol: AnyObject{
    var presenter: FavouritesPresenterProtocol! {get set}
    
    func tableView(numberOfRowsInSection section: Int) -> Int
    func favouritePhoto(for indexPath: IndexPath) -> UnsplashPhoto
    func updateList()
}

class FavouritesInteractor: FavouritesInteractorProtocol{
    var favourites: [UnsplashPhoto] = []
    
    init(){
        updateList()
    }
    
    func updateList(){
        favourites = DatabaseManager.getLikedPhotos() ?? []
    }
    
    func tableView(numberOfRowsInSection section: Int) -> Int {
        favourites.count
    }
    
    func favouritePhoto(for indexPath: IndexPath) -> UnsplashPhoto {
        favourites[indexPath.row]
    }
    
    weak var presenter: FavouritesPresenterProtocol!
}
