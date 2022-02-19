import UIKit
extension AboutView{
    func configureView() {
        view.backgroundColor = .white
        let stackView = UIStackView(arrangedSubviews: [descriptionLabel,
                                                       authorNameLabel,
                                                       dateCreatedLabel,
                                                       locationLabel,
                                                       downloadsLabel])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        view.addSubview(likeButton)
        view.addSubview(downloadButton)
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            imageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25),
            imageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            
            stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -20),
            
            likeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            likeButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            likeButton.heightAnchor.constraint(equalToConstant: 48),
            likeButton.widthAnchor.constraint(equalToConstant: 48),
            
            downloadButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            downloadButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            downloadButton.heightAnchor.constraint(equalToConstant: 48),
            downloadButton.widthAnchor.constraint(equalToConstant: 48)
            
        ])
    }
}
