//
//  AboutInteractor.swift
//  PhotoNet
//
//  Created by Aralbek Muhammed on 17.02.2022.
//

import Foundation
import UIKit
import SDWebImage
protocol AboutInteractorProtocol: AnyObject{
    var presenter: AboutPresenterProtocol! {get set}
    
    func getInformation(by id: String, completionHandler: @escaping(UnsplashPhoto?)->())
    func checkIfDatabaseContains(id: String)->Bool
    func like(id: String, completionHandler: @escaping()->())
    func dislike(id: String)
    func getImage(byID id: String, completionHandler: @escaping(UIImage?)->())
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
    
    func getImage(byID id: String, completionHandler: @escaping (UIImage?) -> ()) {
        getInformation(by: id) { photo in
            guard let photo = photo,
                  let url = URL(string: photo.urls.full) else{completionHandler(nil); return}
            DispatchQueue.global(qos: .userInitiated).async {
                guard let data = try? Data(contentsOf: url) else{
                    DispatchQueue.main.async {
                        completionHandler(nil)
                    }
                    return
                }
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    completionHandler(image)
                }
            }
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
