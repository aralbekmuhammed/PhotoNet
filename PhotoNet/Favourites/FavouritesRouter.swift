//
//  FavouritesRouter.swift
//  PhotoNet
//
//  Created by Aralbek Muhammed on 17.02.2022.
//

import Foundation

protocol FavouritesRouterProtocol: AnyObject{
    var view: FavouritesViewProtocol! {get set}
    func presentAboutVC(_ aboutVC: AboutViewProtocol)
}
class FavouritesRouter: FavouritesRouterProtocol{
    weak var view: FavouritesViewProtocol!
    func presentAboutVC(_ aboutVC: AboutViewProtocol){
        view.present(aboutVC,
                     animated: true)
    }
}
