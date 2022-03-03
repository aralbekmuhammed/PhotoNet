import Foundation
import Alamofire
struct UnsplashPhoto: Codable{
    let id: String
    let created_at: String
    let description: String?
    let alt_description: String?
    let location: Location?
    let width: Int
    let height: Int
    var resolution: String{
        "\(width) x \(height)"
    }
    let user: User
    let urls: URLS
    let links: Links
    let downloads: Int?
    struct Links: Codable{
        let download: String
    }
    struct URLS: Codable{
        let thumb: String
        let regular: String
        let full: String
    }
    struct User: Codable{
        let name: String
    }
    struct Location: Codable{
        let title: String?
    }
}
class UnsplashManager{
    private static let authorizationHeader: HTTPHeaders = ["Authorization": "Client-ID zF_kWP3d1uAFTEJ7LvITqO1P36LLF3TOJtrJGWY6piQ"]
    static func getGallery(page: Int = 1,completionHandler: @escaping([UnsplashPhoto]?)->()){
        AF.request("https://api.unsplash.com/photos/?page=\(page)",
                   method: .get,
                   encoding: JSONEncoding.default,
                   headers: authorizationHeader).responseDecodable(of: [UnsplashPhoto].self) { result in
            let photos = try? result.result.get()
            completionHandler(photos)
        }
    }
    static func getDetailedPhoto(id: String, completionHandler: @escaping(UnsplashPhoto?)->()){
        let url = "https://api.unsplash.com/photos/\(id)"
        AF.request(url,
                   method: .get,
                   encoding: JSONEncoding.default,
                   headers: authorizationHeader).responseDecodable(of: UnsplashPhoto.self) { result in
            let photo = try? result.result.get()
            completionHandler(photo)
        }
    }
    private struct SearchResult: Codable{
        let results: [UnsplashPhoto]?
    }
    static func getSearchResult(search: String, page: Int = 1, completionHandler: @escaping([UnsplashPhoto]?)->()){
        guard let searchText = search.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) else{completionHandler(nil); return}
        let url = "https://api.unsplash.com/search/photos/?page=\(page)&query=\(searchText)"
        AF.request(url,
                   method: .get,
                   encoding: JSONEncoding.default,
                   headers: authorizationHeader).responseDecodable(of: SearchResult.self) { result in
            let photo = try? result.result.get()
            completionHandler(photo?.results)
        }
    }
}
