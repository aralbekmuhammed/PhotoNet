//
//  FavouritesView.swift
//  PhotoNet
//
//  Created by Aralbek Muhammed on 17.02.2022.
//

import UIKit

protocol AboutViewProtocol: UIViewController{
    var presenter: AboutPresenterProtocol! {get set}
    var configurator: AboutConfiguratorProtocol {get}
    var id: String{get}
    var imageView: UIImageView{get set}
    var authorNameLabel: UILabel{get set}
    var dateCreatedLabel: UILabel{get set}
    var locationLabel: UILabel{get set}
    var downloadsLabel: UILabel{get set}
    var likeButton: UIButton{get set}
    var isLiked: Bool {get set}
    var likeListDelegate: LikeEditingDelegate? {get set}
    
    func configureView()
    func setImageViewImage(toLink link: String)
    func setAuthorName(to name: String)
    func setDateLabel(to date: String)
    func setLocationLabel(to location: String?)
    func setDownloads(to downloads: Int?)
}

protocol LikeEditingDelegate: AnyObject{
    func likeListEdited()
}

class AboutView: UIViewController, AboutViewProtocol{
    
    lazy var likeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .darkGray
        button.tintColor = .red
        button.setPreferredSymbolConfiguration(.init(pointSize: 25), forImageIn: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 8
        button.setImage(.init(systemName: "heart"), for: .normal)
        button.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var isLiked = false{
        didSet{
            likeButton.setImage(isLiked ? .init(systemName: "heart.fill") : .init(systemName: "heart"), for: .normal)
        }
    }
    
    var likeListDelegate: LikeEditingDelegate?
    
    lazy var downloadsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 25
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    
    lazy var authorNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var dateCreatedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        return label
        
    }()
    
    lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        return label
        
    }()
    
    var presenter: AboutPresenterProtocol!
    
    var configurator: AboutConfiguratorProtocol = AboutConfigurator()
    
    var id: String
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(vc: self)
        presenter.configureView()
        
    }
    
    init(id: String){
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    func setImageViewImage(toLink link: String){
        imageView.setImageByURL(link)
    }
    
    func setAuthorName(to name: String){
        let description = NSAttributedString(string: "Author name: ",
                                             attributes: [
                                                .foregroundColor: UIColor.black,
                                                .font: UIFont.systemFont(ofSize: 18, weight: .semibold)
                                             ])
        let authorName = NSAttributedString(string: name,
                                            attributes: [
                                                .foregroundColor: UIColor.black,
                                                .font: UIFont.systemFont(ofSize: 17, weight: .medium)
                                            ])
        let finalText = NSMutableAttributedString()
        finalText.append(description)
        finalText.append(authorName)
        authorNameLabel.attributedText = finalText
    }
    
    func setDateLabel(to date: String){
        let description = NSAttributedString(string: "Created date: ",
                                             attributes: [
                                                .foregroundColor: UIColor.black,
                                                .font: UIFont.systemFont(ofSize: 18, weight: .semibold)
                                             ])
        let createdDate = NSAttributedString(string: date,
                                             attributes: [
                                                .foregroundColor: UIColor.black,
                                                .font: UIFont.systemFont(ofSize: 17, weight: .medium)
                                             ])
        let finalText = NSMutableAttributedString()
        finalText.append(description)
        finalText.append(createdDate)
        dateCreatedLabel.attributedText = finalText
    }
    
    func setLocationLabel(to location: String?){
        let description = NSAttributedString(string: "Location: ",
                                             attributes: [
                                                .foregroundColor: UIColor.black,
                                                .font: UIFont.systemFont(ofSize: 18, weight: .semibold)
                                             ])
        let location = NSAttributedString(string: location ?? "Some beautiful place...",
                                          attributes: [
                                            .foregroundColor: UIColor.black,
                                            .font: UIFont.systemFont(ofSize: 17, weight: .medium)
                                          ])
        let finalText = NSMutableAttributedString()
        finalText.append(description)
        finalText.append(location)
        locationLabel.attributedText = finalText
        
    }
    
    func setDownloads(to downloads: Int?){
        let description = NSAttributedString(string: "Downloaded: ",
                                             attributes: [
                                                .foregroundColor: UIColor.black,
                                                .font: UIFont.systemFont(ofSize: 18, weight: .semibold)
                                             ])
        let downloads = NSAttributedString(string: downloads?.description ?? "Some beautiful count...",
                                           attributes: [
                                            .foregroundColor: UIColor.black,
                                            .font: UIFont.systemFont(ofSize: 17, weight: .medium)
                                           ])
        let finalText = NSMutableAttributedString()
        finalText.append(description)
        finalText.append(downloads)
        downloadsLabel.attributedText = finalText
        
    }
    
    @objc func likeButtonTapped(){
        presenter.likeButtonTapped()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}