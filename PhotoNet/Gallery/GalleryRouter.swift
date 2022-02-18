//
//  GalleryRouter.swift
//  PhotoNet
//
//  Created by Aralbek Muhammed on 17.02.2022.
//

import Foundation

protocol GalleryRouterProtocol: AnyObject{
    var view: GalleryViewProtocol! {get set}
    func presentAboutVC(_ aboutVC: AboutViewProtocol)
}
class GalleryRouter: GalleryRouterProtocol{
    weak var view: GalleryViewProtocol!
    func presentAboutVC(_ aboutVC: AboutViewProtocol){
        view.present(aboutVC,
                     animated: true)
    }
}
