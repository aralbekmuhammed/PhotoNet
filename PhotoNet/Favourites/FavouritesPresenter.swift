//
//  FavouritesPresenter.swift
//  PhotoNet
//
//  Created by Aralbek Muhammed on 17.02.2022.
//

import Foundation
import UIKit

protocol FavouritesPresenterProtocol: AnyObject{
    var view: FavouritesViewProtocol! {get set}
    var interactor: FavouritesInteractorProtocol! {get set}
    var router: FavouritesRouterProtocol! {get set}
    
    func configureView()
    func tableView(numberOfRowsInSection section: Int) -> Int
    func favouritePhoto(for indexPath: IndexPath)->UnsplashPhoto
    func tableView(didSelectRowAt indexPath: IndexPath)
    func likeListEdited()
}
class FavouritesPresenter: FavouritesPresenterProtocol, LikeEditingDelegate{
    func tableView(didSelectRowAt indexPath: IndexPath) {
        let selectedPhoto = interactor.favouritePhoto(for: indexPath)
        let aboutVC = AboutView(id: selectedPhoto.id)
        aboutVC.likeListDelegate = self
        router.presentAboutVC(aboutVC)
    }
    func likeListEdited() {
        interactor.updateList()
        view.tableView.reloadData()
        let isEmpty = interactor.tableView(numberOfRowsInSection: 0) == 0
        view.setStatus(empty: isEmpty)
    }
    
    func tableView(numberOfRowsInSection section: Int) -> Int {
        interactor.tableView(numberOfRowsInSection: section)
    }
    
    func favouritePhoto(for indexPath: IndexPath) -> UnsplashPhoto {
        interactor.favouritePhoto(for: indexPath)
    }

    weak var view: FavouritesViewProtocol!
    
    var interactor: FavouritesInteractorProtocol!
    
    var router: FavouritesRouterProtocol!
    
    func configureView() {
        view.configureView()
        let isEmpty = interactor.tableView(numberOfRowsInSection: 0) == 0
        view.setStatus(empty: isEmpty)
    }
}
