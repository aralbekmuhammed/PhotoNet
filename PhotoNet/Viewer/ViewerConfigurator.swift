//
//  ViewerConfigurator.swift
//  PhotoNet
//
//  Created by Aralbek Muhammed on 25.02.2022.
//  
//

import Foundation

class ViewerConfigurator: ViewerConfiguratorProtocol {
    
    // MARK: - Static methods
    static func configure(_ vc: ViewerViewProtocol) {
        
        let interactor = ViewerInteractor()
        let presenter = ViewerPresenter()
        let router = ViewerRouter()
        
        interactor.presenter = presenter
        
        vc.presenter = presenter
        
        router.view = vc
        
        presenter.interactor = interactor
        presenter.view = vc
        presenter.router = router

    }
    
}
