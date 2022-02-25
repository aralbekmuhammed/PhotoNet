//
//  ViewerContract.swift
//  PhotoNet
//
//  Created by Aralbek Muhammed on 25.02.2022.
//  
//

import Foundation
import UIKit


// MARK: - View
protocol ViewerViewProtocol: UIViewController {
    var presenter: ViewerPresenterProtocol! { get set }
    var imageLink: String { get }
    var imageView: UIImageView { get }
    
    func setImageViewImage(toLink link: String, completionHandler: @escaping(Bool)->())
    func configureView()
    func showErrorAlert()
}


// MARK: - Interactor
protocol ViewerInteractorProtocol: AnyObject {
    var presenter: ViewerPresenterProtocol! { get set }
}


// MARK: - Presenter
protocol ViewerPresenterProtocol: AnyObject {
    var view: ViewerViewProtocol! { get set }
    var interactor: ViewerInteractorProtocol! { get set }
    var router: ViewerRouterProtocol! { get set }
    
    func viewDidTapOrSwipe()
    func dismissButtonTapped()
    func configureView()
}


// MARK: - Router
protocol ViewerRouterProtocol: AnyObject {
    var view: ViewerViewProtocol! { get set }
    
    func dismiss()
}


//MARK: - Configurator
protocol ViewerConfiguratorProtocol: AnyObject {
    static func configure(_ vc: ViewerViewProtocol)
}
