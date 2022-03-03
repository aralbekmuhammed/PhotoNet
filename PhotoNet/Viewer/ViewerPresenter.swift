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
        
        view.showSpinner()
        
        let link = view.imageLink
        interactor.getImage(from: link) { [unowned self] downloadedImage in
            DispatchQueue.main.async {
                
                view.dismissSpinner()
                
                guard let image = downloadedImage else { view.showErrorAlert(); return }
                
                view.setImageViewImage(to: image)
                
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
