//
//  SharePhotoController.swift
//  ResuMe
//
//  Created by Yi Zheng on 2019-04-17.
//  Copyright © 2019 Yi Zheng. All rights reserved.
//

import UIKit
import Firebase

class SharePhotoController: UIViewController {
    
    var selectedImage: UIImage? {
        didSet{
            selectedImageView.image = selectedImage
        }
    }
    
    let containerView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        return v
    }()
    
    let selectedImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 18)
        return tv
    }()
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @objc func handleShare(){
        guard let image = selectedImage else {return}
        guard let uploadData = image.jpegData(compressionQuality: 0.5) else {return}
        
//        guard let uploadData = UIImageJPEGRepresentation(image, 0.5) else {return}
        
        let storageRef = Storage.storage().reference()
        let fileName = NSUUID().uuidString
        let storageRefChild = storageRef.child("post_images/\(fileName).jpg")
        storageRefChild.putData(uploadData, metadata: nil) { (metadata, error) in
            if let err = error {
                print("Failed upload image to storage", err)
                return
            }
            storageRefChild.downloadURL(completion: { (url, error) in
                if let err = error {
                    print("Failed to download image url", err)
                    return
                }
                guard let imageUrl = url?.absoluteString else {return}
                self.saveToDatabaseWithImageUrl(imageUrl: imageUrl)
                
            })
        }
    }
    
    fileprivate func saveToDatabaseWithImageUrl(imageUrl: String){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let caption = textView.text, !caption.isEmpty else {return}
        guard let image = selectedImage else {return}
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        let dictionaryValues = ["postImageUrl": imageUrl, "caption": caption, "imageWidth": image.size.width, "imageHeight": image.size.height, "creationDate": Date().timeIntervalSince1970] as [String: Any]
        
        let databaseRef = Database.database().reference()
        let databaseRefChild = databaseRef.child("posts").child(uid).childByAutoId()
        databaseRefChild.updateChildValues(dictionaryValues) { (error, ref) in
            if let err = error {
                print("Failed to update data to database", err)
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                return
            }
            print("successed to update data to database")
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(handleShare))
        
        view.addSubview(containerView)
        view.addSubview(selectedImageView)
        view.addSubview(textView)
        
        containerView.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 100)
        selectedImageView.anchor(containerView.topAnchor, left: containerView.leftAnchor, bottom: containerView.bottomAnchor, right: nil, topConstant: 8, leftConstant: 8, bottomConstant: 8, rightConstant: 0, widthConstant: 84, heightConstant: 0)
        textView.anchor(selectedImageView.topAnchor, left: selectedImageView.rightAnchor, bottom: containerView.bottomAnchor, right: containerView.rightAnchor, topConstant: 0, leftConstant: 4, bottomConstant: 0, rightConstant: 8, widthConstant: 0, heightConstant: 0)
        
    }
}

