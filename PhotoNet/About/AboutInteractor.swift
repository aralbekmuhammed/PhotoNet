//
//  AboutInteractor.swift
//  PhotoNet
//
//  Created by Aralbek Muhammed on 17.02.2022.
//

import Foundation

protocol AboutInteractorProtocol: AnyObject{
    var presenter: AboutPresenterProtocol! {get set}
    
    func getInformation(by id: String, completionHandler: @escaping(UnsplashPhoto?)->())
    func checkIfDatabaseContains(id: String)->Bool
    func like(id: String, completionHandler: @escaping()->())
    func dislike(id: String)
}
class AboutInteractor: AboutInteractorProtocol{
    
    func like(id: String, completionHandler: @escaping()->()) {
        UnsplashManager.getDetailedPhoto(id: id) { photo in
            if let photo = photo {
                DatabaseManager.like(photo)
            }
            completionHandler()
        }
    }
    
    func dislike(id: String) {
        DatabaseManager.unlike(id: id)
    }
    
    weak var presenter: AboutPresenterProtocol!
    
    func getInformation(by id: String, completionHandler: @escaping (UnsplashPhoto?) -> ()) {
        UnsplashManager.getDetailedPhoto(id: id) { photo in
            completionHandler(photo)
        }
    }
    
    func checkIfDatabaseContains(id: String) -> Bool {
        let likes = DatabaseManager.getLikedPhotos()
        return likes?.contains(where: {$0.id == id}) ?? false
    }
}
