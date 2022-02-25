//
//  ViewerRouter.swift
//  PhotoNet
//
//  Created by Aralbek Muhammed on 25.02.2022.
//  
//

import Foundation
import UIKit

class ViewerRouter: ViewerRouterProtocol {
    
    // MARK: - Properties
    weak var view: ViewerViewProtocol!
    
    
    func dismiss() {
        view.dismiss(animated: true)
    }
    
}
