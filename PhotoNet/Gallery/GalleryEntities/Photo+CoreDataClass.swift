//
//  Photo+CoreDataClass.swift
//  PhotoNet
//
//  Created by Aralbek Muhammed on 17.02.2022.
//
//

import Foundation
import CoreData

@objc(Photo)
public class Photo: NSManagedObject {
    static func save(_ unsplashPhoto: UnsplashPhoto){
        let coder = JSONEncoder()
        let data = try? coder.encode(unsplashPhoto)
        let photoObject = Photo(context: context)
        photoObject.photo = data
        photoObject.photoID = unsplashPhoto.id
        try? context.save()
    }
    func get()->UnsplashPhoto?{
        guard let data = self.photo else{return nil}
        let decoder = JSONDecoder()
        let decoded = try? decoder.decode(UnsplashPhoto.self, from: data)
        return decoded
    }
}
