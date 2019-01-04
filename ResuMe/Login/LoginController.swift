//
//  LoginController.swift
//  ResuMe
//
//  Created by Yi Zheng on 2019-01-03.
//  Copyright © 2019 Yi Zheng. All rights reserved.
//

import UIKit
import Firebase

class LoginController: UIViewController {
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
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
    
    let loginButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitleColor(.white, for: .normal)
        b.isEnabled = false
        b.backgroundColor = UIColor(r: 149, g: 204, b: 244)
        b.layer.cornerRadius = 5
        b.setTitle("Login", for: .normal)
        b.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        b.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return b
    }()
    
    let gotoSignUpPageButton: UIButton = {
        let b = UIButton()
        let attributedTitle = NSMutableAttributedString(string: "Don't have a account? ", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        attributedTitle.append(NSAttributedString(string: "Sign Up", attributes: [NSAttributedStringKey.foregroundColor: UIColor(r: 17, g: 154, b: 237)]))
        b.setAttributedTitle(attributedTitle, for: .normal)
        b.addTarget(self, action: #selector(handlerShowSignUpPage), for: .touchUpInside)
        return b
    }()
    
    @objc func handlerShowSignUpPage(){
        let signUpController = SignUpController()
        navigationController?.pushViewController(signUpController, animated: true)
    }
    
    @objc func handleLogin(){
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let err = error {
                print("failed to sign in:\n", err)
                return
            }
            print("successed to sign in:\n", user?.user.uid ?? "")
            guard let mainTabBarController = UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController else {return}
            mainTabBarController.setupTabBarViewController()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func handleInput(){
        let isTextFieldValied = emailTextField.text?.count ?? 0 > 0 && passwordTextField.text?.count ?? 0 >= 6
        
        if isTextFieldValied {
            loginButton.isEnabled = true
            loginButton.backgroundColor = UIColor(r: 17, g: 154, b: 237)
        }else {
            loginButton.isEnabled = false
            loginButton.backgroundColor = UIColor(r: 149, g: 204, b: 244)
        }
    }
    
    func setupNavBar(){
        navigationItem.title = "Login"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
    }
    
    @objc func handleCancel(){
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavBar()
        
        let inputStackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton])
        inputStackView.distribution = .fillEqually
        inputStackView.axis = .vertical
        inputStackView.spacing = 10
        view.addSubview(inputStackView)
        inputStackView.anchorCenterYToSuperview()
        inputStackView.anchor(nil, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 40, bottomConstant: 0, rightConstant: 40, widthConstant: 0, heightConstant: 0)
        
        view.addSubview(gotoSignUpPageButton)
        gotoSignUpPageButton.anchor(nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
}
