//
//  Photo+CoreDataProperties.swift
//  PhotoNet
//
//  Created by Aralbek Muhammed on 17.02.2022.
//
//

import Foundation
import CoreData


extension Photo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo")
    }

    @NSManaged public var photo: Data?
    @NSManaged public var photoID: String?

}

extension Photo : Identifiable {

}
