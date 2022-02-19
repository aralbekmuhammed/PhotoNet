//
//  FavouritesView.swift
//  PhotoNet
//
//  Created by Aralbek Muhammed on 17.02.2022.
//

import UIKit
import SDWebImage
protocol AboutViewProtocol: UIViewController{
    var presenter: AboutPresenterProtocol! {get set}
    var configurator: AboutConfiguratorProtocol {get}
    var id: String{get}
    var likeListDelegate: LikeEditingDelegate? {get set}
    var isLiked: Bool {get set}
    
    func configureView()
    func setImageViewImage(toLink link: String)
    func setAuthorName(to name: String)
    func setDateLabel(to date: String)
    func setDescriptionLabel(to description: String?)
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
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
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
        imageView.sd_setImage(with: URL(string: link))
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
        guard let location = location else {
            locationLabel.removeFromSuperview()
            return
        }
        let description = NSAttributedString(string: "Location: ",
                                             attributes: [
                                                .foregroundColor: UIColor.black,
                                                .font: UIFont.systemFont(ofSize: 18, weight: .semibold)
                                             ])
        let place = NSAttributedString(string: location,
                                          attributes: [
                                            .foregroundColor: UIColor.black,
                                            .font: UIFont.systemFont(ofSize: 17, weight: .medium)
                                          ])
        let finalText = NSMutableAttributedString()
        finalText.append(description)
        finalText.append(place)
        locationLabel.attributedText = finalText
        
    }
    
    func setDescriptionLabel(to description: String?) {
        guard let descriptionText = description else {
            descriptionLabel.removeFromSuperview()
            return
        }
        let description = NSAttributedString(string: "Description: ",
                                             attributes: [
                                                .foregroundColor: UIColor.black,
                                                .font: UIFont.systemFont(ofSize: 18, weight: .semibold)
                                             ])
        let text = NSAttributedString(string: descriptionText,
                                          attributes: [
                                            .foregroundColor: UIColor.black,
                                            .font: UIFont.systemFont(ofSize: 17, weight: .medium)
                                          ])
        let finalText = NSMutableAttributedString()
        finalText.append(description)
        finalText.append(text)
        descriptionLabel.attributedText = finalText

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
