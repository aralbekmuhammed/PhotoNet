class DatabaseManager{
    static func like(_ unsplashPhoto: UnsplashPhoto){
        Photo.save(unsplashPhoto)
    }
    static func unlike(id: String){
        if let datas = try? context.fetch(Photo.fetchRequest()),
           let photoToUnlike = datas.first(where: {$0.photoID == id}){
            context.delete(photoToUnlike)
            try? context.save()
        }
    }
    static func getLikedPhotos()->[UnsplashPhoto]?{
        guard let datas = try? context.fetch(Photo.fetchRequest()) else{return nil}
        let photos = datas.compactMap({$0.get()})
        return photos
    }
}
