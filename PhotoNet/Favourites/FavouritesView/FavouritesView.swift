//
//  FavouritesView.swift
//  PhotoNet
//
//  Created by Aralbek Muhammed on 17.02.2022.
//

import UIKit

protocol FavouritesViewProtocol: UIViewController{
    func configureView()
    
    var presenter: FavouritesPresenterProtocol! {get set}
    var configurator: FavouritesConfiguratorProtocol {get}
    var tableView: UITableView {get set}
    var statusLabel: UILabel{get set}
    
    func setStatus(empty: Bool)
}
class FavouritesView: UIViewController, FavouritesViewProtocol{
    
    var presenter: FavouritesPresenterProtocol!
    
    var configurator: FavouritesConfiguratorProtocol = FavouritesConfigurator()
    
    lazy var statusLabel: UILabel = {
       let label = UILabel()
        label.text = "Look's like it's empty here..."
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .darkText
        label.font = .systemFont(ofSize: 40, weight: .semibold)
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FavouriteTVC.self, forCellReuseIdentifier: "FavouriteTVC")
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.likeListEdited()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(vc: self)
        presenter.configureView()
    }
    
    func setStatus(empty: Bool) {
        if empty{
            statusLabel.isHidden = false
            tableView.isHidden = true
        }else{
            tableView.isHidden = false
            statusLabel.isHidden = true
        }
    }

    
}
