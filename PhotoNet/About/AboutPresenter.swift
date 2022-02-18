//
//  AboutPresenter.swift
//  PhotoNet
//
//  Created by Aralbek Muhammed on 17.02.2022.
//

import Foundation
import UIKit

protocol AboutPresenterProtocol: AnyObject{
    var view: AboutViewProtocol! {get set}
    var interactor: AboutInteractorProtocol! {get set}
    var router: AboutRouterProtocol! {get set}
    
    func likeButtonTapped()
    func configureView()
    
}
class AboutPresenter: AboutPresenterProtocol{
    
    weak var view: AboutViewProtocol!
    
    var interactor: AboutInteractorProtocol!
    
    var router: AboutRouterProtocol!
    
    func configureView() {
        view.configureView()
        interactor.getInformation(by: view.id) { [weak self] photo in
            guard let self = self,
                  let photo = photo else{return}
            self.view.setImageViewImage(toLink: photo.urls.regular)
            self.view.setAuthorName(to: photo.user.name)
            self.view.setDateLabel(to: String(photo.created_at.prefix(10)))
            self.view.setLocationLabel(to: photo.location?.title)
            self.view.setDownloads(to: photo.downloads)
        }
        let isLiked = interactor.checkIfDatabaseContains(id: view.id)
        view.isLiked = isLiked
        
    }
    
    func likeButtonTapped() {
        let isLiked = interactor.checkIfDatabaseContains(id: view.id)
        if isLiked{
            // should dislike
            interactor.dislike(id: view.id)
            view.isLiked = interactor.checkIfDatabaseContains(id: view.id)
            self.view.likeListDelegate?.likeListEdited()
        }else{
            // should like
            interactor.like(id: view.id) { [weak self] in
                guard let self = self else{return}
                self.view.isLiked = self.interactor.checkIfDatabaseContains(id: self.view.id)
                self.view.likeListDelegate?.likeListEdited()
            }
        }
    }
    
}
