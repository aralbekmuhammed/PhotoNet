//
//  MainTabBarController.swift
//  PhotoNet
//
//  Created by Aralbek Muhammed on 17.02.2022.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let viewControllers = [getGalleryVC(), getFavouritesVC()]
        setViewControllers(viewControllers, animated: false)
        setUpTabBar()
    }
    
    private func setUpTabBar() {
        let appearance = UITabBarAppearance()
        tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        }
    }
    
    private func getGalleryVC()->UIViewController{
        let galleryVC = GalleryView()
        galleryVC.tabBarItem.title = "Gallery"
        galleryVC.tabBarItem.image = UIImage(systemName: "photo")
        galleryVC.tabBarItem.selectedImage = UIImage(systemName: "photo.fill")
        return galleryVC
    }
    
    private func getFavouritesVC()->UIViewController{
        let favouritesVC = FavouritesView()
        favouritesVC.tabBarItem.title = "Favourites"
        favouritesVC.tabBarItem.image = UIImage(systemName: "heart")
        favouritesVC.tabBarItem.selectedImage = UIImage(systemName: "heart.fill")
        return favouritesVC
    }
    
}
