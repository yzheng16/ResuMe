//
//  MainTabBarController.swift
//  ResuMe
//
//  Created by Yi Zheng on 2019-01-01.
//  Copyright © 2019 Yi Zheng. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        delegate = self
        setupTabBarViewController()
    }
    
    func setupTabBarViewController() {
        //when the icon is selected, it will be black, otherwise it will be blue
        tabBar.tintColor = .black
        //let layout = UICollectionViewFlowLayout()
        let homeNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "home_unselected"), selectedImage: #imageLiteral(resourceName: "home_selected"))
        let searchNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "search_unselected") , selectedImage: #imageLiteral(resourceName: "search_selected") )
        let meNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "profile_unselected") , selectedImage: #imageLiteral(resourceName: "profile_selected"))
        let likeNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "like_unselected"), selectedImage: #imageLiteral(resourceName: "like_selected"))
        let loginNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "home_unselected"), selectedImage: #imageLiteral(resourceName: "home_selected"))
        
        viewControllers = [homeNavController, searchNavController, meNavController, likeNavController, loginNavController]
        
        guard let items = tabBar.items else {return}
        
        for item in items {
            item.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0)
        }
    }
    
    fileprivate func templateNavController(unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController = UIViewController()) -> UINavigationController{
        let viewController = rootViewController
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.image = unselectedImage
        navController.tabBarItem.selectedImage = selectedImage
        return navController
    }
}
