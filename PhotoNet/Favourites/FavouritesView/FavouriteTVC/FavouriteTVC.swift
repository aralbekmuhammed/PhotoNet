//
//  FavouriteTVC.swift
//  PhotoNet
//
//  Created by Aralbek Muhammed on 17.02.2022.
//

import UIKit

class FavouriteTVC: UITableViewCell {
    
    lazy var photoView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    
    lazy var autorNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 17)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView(){
        contentView.addSubview(photoView)
        contentView.addSubview(autorNameLabel)
        NSLayoutConstraint.activate([
            photoView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            photoView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            photoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            photoView.rightAnchor.constraint(equalTo: autorNameLabel.leftAnchor, constant: -10),
            photoView.widthAnchor.constraint(equalTo: photoView.heightAnchor),
            autorNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            autorNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            autorNameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ])
    }
    
    func configure(with unsplashPhoto: UnsplashPhoto){
        photoView.setImageByURL(unsplashPhoto.urls.thumb)
        autorNameLabel.text = unsplashPhoto.user.name
    }
    
}
