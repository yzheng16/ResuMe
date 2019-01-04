//
//  LogoutController.swift
//  ResuMe
//
//  Created by Yi Zheng on 2019-01-04.
//  Copyright © 2019 Yi Zheng. All rights reserved.
//

import UIKit
import Firebase

class LogoutController: UIViewController {
    
    var user: User?{
        didSet{
            greetingLabel.text = "Hi " + (self.user?.username)! + ",\nThank you for using my app.\nHope you have a good day."
        }
    }
    
    let greetingLabel: UILabel = {
        let l = UILabel()
        l.text = "Hi    ,\nThank you for using my app.\nHope you have a good day."
        l.numberOfLines = 0
        return l
    }()
    
    func setupNavBar(){
        navigationItem.title = "Welcome"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "gear").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleLogout))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
    }
    
    @objc func handleLogout(){
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { (_) in
            do{
                try Auth.auth().signOut()
                guard let mainTabBarController = UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController else {return}
                mainTabBarController.setupTabBarViewController()
                self.dismiss(animated: true, completion: nil)
            }catch let error{
                print("failed to log out:\n", error)
            }
            
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func handleCancel(){
        self.dismiss(animated: true, completion: nil)
    }
    
    fileprivate func fetchUser(){
        let uid = Auth.auth().currentUser?.uid ?? ""
        let ref = Database.database().reference().child("users").child(uid)
        ref.observeSingleEvent(of: .value) { (snapshot) in
            guard let dictionary = snapshot.value as? [String: Any] else {return}
            //print(dictionary)//["username": Yi Zheng (Amy)]
            self.user = User(uid: uid, dictionary: dictionary)
            //print(self.user?.username)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavBar()
        
        fetchUser()
        
        view.addSubview(greetingLabel)
        greetingLabel.anchorCenterSuperview()
        
    }
}
