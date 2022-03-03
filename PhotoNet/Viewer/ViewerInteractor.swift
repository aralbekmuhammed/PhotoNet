//
//  ViewerInteractor.swift
//  PhotoNet
//
//  Created by Aralbek Muhammed on 25.02.2022.
//  
//

import Foundation
import UIKit

class ViewerInteractor: ViewerInteractorProtocol {
    
    // MARK: - Properties
    weak var presenter: ViewerPresenterProtocol!
    
    func getImage(from link: String, completionHandler: @escaping (UIImage?) -> ()) {
        DispatchQueue.global(qos: .userInitiated).async {
            
            guard let url = URL(string: link),
                  let data = try? Data(contentsOf: url),
                  let image = UIImage(data: data) else { completionHandler(nil); return }
            
            completionHandler(image)
        }
        
    }
}
