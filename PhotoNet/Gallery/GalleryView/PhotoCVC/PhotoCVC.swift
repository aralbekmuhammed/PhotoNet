//
//  PhotoCVC.swift
//  PhotoNet
//
//  Created by Aralbek Muhammed on 17.02.2022.
//

import UIKit

class PhotoCVC: UICollectionViewCell {
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .lightGray
        imageView.clipsToBounds = true
        return imageView
    }()
    lazy var autorLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .black.withAlphaComponent(0.5)
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView(){
        contentView.addSubview(imageView)
        imageView.addSubview(autorLabel)
        imageView.layer.cornerRadius = 13
        imageView.translatesAutoresizingMaskIntoConstraints = false
        autorLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            autorLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            autorLabel.leftAnchor.constraint(equalTo: imageView.leftAnchor),
            autorLabel.rightAnchor.constraint(equalTo: imageView.rightAnchor),
            autorLabel.heightAnchor.constraint(equalToConstant: 35)
        ])
    }
    func configure(with unsplashPhoto: UnsplashPhoto, shouldShowAutorLabel: Bool = true){
        autorLabel.isHidden = !shouldShowAutorLabel
        autorLabel.text = unsplashPhoto.user.name
        imageView.setImageByURL(unsplashPhoto.urls.thumb)
    }
}
