//
//  ViewerPresenter.swift
//  PhotoNet
//
//  Created by Aralbek Muhammed on 25.02.2022.
//  
//

import Foundation

class ViewerPresenter: ViewerPresenterProtocol {
    
    // MARK: - Properties
    weak var view: ViewerViewProtocol!
    
    var interactor: ViewerInteractorProtocol!
    
    var router: ViewerRouterProtocol!
    
    func configureView() {
        view.configureView()
        view.setImageViewImage(toLink: view.imageLink) { [unowned self] success in
            
            if !success{
                view.showErrorAlert()
            }
            
        }
    }
    
    func dismissButtonTapped() {
        router.dismiss()
    }
    
    func viewDidTapOrSwipe() {
        router.dismiss()
    }
}
