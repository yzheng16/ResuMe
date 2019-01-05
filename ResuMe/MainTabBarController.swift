//
//  MainTabBarController.swift
//  ResuMe
//
//  Created by Yi Zheng on 2019-01-01.
//  Copyright © 2019 Yi Zheng. All rights reserved.
//

import UIKit
import Firebase

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        delegate = self
        setupTabBarViewController()
//        print(Auth.auth().currentUser?.uid ?? "default")
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let index = viewControllers?.index(of: viewController)
        if index == 4 {
            if Auth.auth().currentUser == nil{
                let loginController = LoginController()
                let navLoginController = UINavigationController(rootViewController: loginController)
                present(navLoginController, animated: true, completion: nil)
                setupTabBarViewController()
                return false
            }else {
                //logout page
                let logoutController = LogoutController()
                let navLogoutController = UINavigationController(rootViewController: logoutController)
                present(navLogoutController, animated: true, completion: nil)
                setupTabBarViewController()
                return false
            }
            
        }
        return true
    }
    
    func setupTabBarViewController() {
        //when the icon is selected, it will be black, otherwise it will be blue
        tabBar.tintColor = .black
        let layout = UICollectionViewFlowLayout()
        let homeNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "home_unselected"), selectedImage: #imageLiteral(resourceName: "home_selected"), rootViewController: HomeController(collectionViewLayout: layout))
        let searchNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "search_unselected") , selectedImage: #imageLiteral(resourceName: "search_selected") , rootViewController: UserSearchController(collectionViewLayout: layout))
        let meNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "profile_unselected") , selectedImage: #imageLiteral(resourceName: "profile_selected"))
        let plusNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "plus_unselected") , selectedImage: #imageLiteral(resourceName: "plus_unselected"))
        let likeNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "like_unselected"), selectedImage: #imageLiteral(resourceName: "like_selected"))
        let loginNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "login_unselected"), selectedImage: #imageLiteral(resourceName: "login_selected"))
        
        if Auth.auth().currentUser?.uid == "84o4EIUygdWycplh88r2tCz6vB43"{
            viewControllers = [homeNavController, searchNavController, plusNavController, likeNavController, loginNavController]
        }else{
            viewControllers = [homeNavController, searchNavController, meNavController, likeNavController, loginNavController]
        }
        
        
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
