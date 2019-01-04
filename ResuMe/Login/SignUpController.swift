//
//  SignUpViewController.swift
//  ResuMe
//
//  Created by Yi Zheng on 2019-01-03.
//  Copyright © 2019 Yi Zheng. All rights reserved.
//

import UIKit
import Firebase

class SignUpController: UIViewController {
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(handleInput), for: .editingChanged)
        return tf
    }()
    
    let usernameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Username. Plase use company name with your inital."
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(handleInput), for: .editingChanged)
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.isSecureTextEntry = true
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(handleInput), for: .editingChanged)
        return tf
    }()
    
    let signUpButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitleColor(.white, for: .normal)
        b.isEnabled = false
        b.backgroundColor = UIColor(r: 149, g: 204, b: 244)
        b.layer.cornerRadius = 5
        b.setTitle("Sign Up", for: .normal)
        b.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        b.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return b
    }()
    
    let gotoLoginPageButton: UIButton = {
        let b = UIButton()
        let attributedTitle = NSMutableAttributedString(string: "Already have a account? ", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        attributedTitle.append(NSAttributedString(string: "Log In", attributes: [NSAttributedStringKey.foregroundColor: UIColor(r: 17, g: 154, b: 237)]))
        b.setAttributedTitle(attributedTitle, for: .normal)
        b.addTarget(self, action: #selector(handlerShowLoginPage), for: .touchUpInside)
        return b
    }()
    
    @objc func handleInput(){
        let isTextFieldValied = emailTextField.text?.count ?? 0 > 0 && usernameTextField.text?.count ?? 0 > 0 && passwordTextField.text?.count ?? 0 >= 6
        
        if isTextFieldValied {
            signUpButton.isEnabled = true
            signUpButton.backgroundColor = UIColor(r: 17, g: 154, b: 237)
        }else {
            signUpButton.isEnabled = false
            signUpButton.backgroundColor = UIColor(r: 149, g: 204, b: 244)
        }
    }
    
    @objc func handleSignUp(){
        guard let email = emailTextField.text, email.count > 0 else {return}
        guard let username = usernameTextField.text, username.count > 0 else {return}
        guard let password = passwordTextField.text, password.count >= 6 else {return}
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let err = error {
                print("failed to create user:\n", err)
                return
            }
            print("successfully created user:\n", user?.user.uid ?? "")
            
            guard let uid = user?.user.uid else {return}
            let dictionaryValues = ["username": username] as [String : Any]
            let values = [uid: dictionaryValues]
            Database.database().reference().child("users").updateChildValues(values, withCompletionBlock: { (error, reference) in
                if let err = error {
                    print("Fail to save user info into db\n", err)
                    return
                }
                print("successfully save user info into db")
                
                guard let mainTabBarController = UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController else {return}
                mainTabBarController.setupTabBarViewController()
                self.dismiss(animated: true, completion: nil)
            })
        }
    }
    
    @objc func handlerShowLoginPage(){
        _ = navigationController?.popViewController(animated: true)
        //        let signUpViewController = LoginController()
        //        navigationController?.pushViewController(signUpViewController, animated: true)
    }
    
    func setupNavBar(){
        navigationItem.title = "Sign Up"
        //navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavBar()
        
        
        let inputStackView = UIStackView(arrangedSubviews: [emailTextField, usernameTextField, passwordTextField, signUpButton])
        inputStackView.distribution = .fillEqually
        inputStackView.axis = .vertical
        inputStackView.spacing = 10
        view.addSubview(inputStackView)
        inputStackView.anchorCenterYToSuperview()
        inputStackView.anchor(nil, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 40, bottomConstant: 0, rightConstant: 40, widthConstant: 0, heightConstant: 0)
        
        view.addSubview(gotoLoginPageButton)
        gotoLoginPageButton.anchor(nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
    }
}
