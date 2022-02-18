import UIKit
extension FavouritesView{
    func configureView() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(statusLabel)
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            statusLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            statusLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            statusLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
