//
//  ViewerView.swift
//  PhotoNet
//
//  Created by Aralbek Muhammed on 25.02.2022.
//  
//

import UIKit

class ViewerView: UIViewController, ViewerViewProtocol {
    
    // MARK: - Properties
    var presenter: ViewerPresenterProtocol!
    
    var imageLink: String
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .black.withAlphaComponent(0.9)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    init(imageLink: String){
        self.imageLink = imageLink
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        ViewerConfigurator.configure(self)
        presenter.configureView()
    }
    
    func setImageViewImage(toLink link: String, completionHandler: @escaping(Bool) -> ()) {
        
        imageView.sd_setImage(with: URL(string: link)) { image, _, _, _ in
            let success = image != nil
            
            completionHandler(success)

        }
        
    }
    
    func showErrorAlert() {
        showAlert(withTitle: "Error occurred",
                  message: "Error occurred while downloading photo",
                  actions: [
                    .init(text: "Ok",
                          type: .default,
                          action: { [unowned self] _ in
                              presenter.dismissButtonTapped()
                          })
                  ])
    }
    
    @objc private func didTapOrSwipe(){
        presenter.viewDidTapOrSwipe()
    }
    
    func configureView() {
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(didTapOrSwipe))
        let swipeGR = UISwipeGestureRecognizer(target: self, action: #selector(didTapOrSwipe))
        
        swipeGR.direction = .down
        
        [tapGR,
         swipeGR].forEach({view.addGestureRecognizer($0)})
        
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leftAnchor.constraint(equalTo: view.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: view.rightAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
