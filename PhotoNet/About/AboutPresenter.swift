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
        spinner.show(in: view.view)
        interactor.getInformation(by: view.id) { [weak self] photo in
            spinner.dismiss()
            guard let self = self,
                  let photo = photo else{return}
            self.view.do {
                $0.setImageViewImage(toLink: photo.urls.regular)
                $0.setAuthorName(to: photo.user.name)
                $0.setDateLabel(to: String(photo.created_at.prefix(10)))
                $0.setLocationLabel(to: photo.location?.title)
                $0.setDownloads(to: photo.downloads)
                $0.setDescriptionLabel(to: photo.description)
            }
        }
        let isLiked = interactor.checkIfDatabaseContains(id: view.id)
        view.isLiked = isLiked
        
    }
    
    func likeButtonTapped() {
        spinner.show(in: view.view)
        let isLiked = interactor.checkIfDatabaseContains(id: view.id)
        if isLiked{
            // should dislike
            interactor.dislike(id: view.id)
            view.isLiked = interactor.checkIfDatabaseContains(id: view.id)
            self.view.likeListDelegate?.likeListEdited()
            spinner.dismiss()
        }else{
            // should like
            interactor.like(id: view.id) { [weak self] in
                spinner.dismiss()
                guard let self = self else{return}
                self.view.isLiked = self.interactor.checkIfDatabaseContains(id: self.view.id)
                self.view.likeListDelegate?.likeListEdited()
            }
        }
    }
    
}
