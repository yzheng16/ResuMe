//
//  HomeController.swift
//  ResuMe
//
//  Created by Yi Zheng on 2019-01-02.
//  Copyright © 2019 Yi Zheng. All rights reserved.
//

import UIKit
import Firebase

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout, HomePostCellDelegate {
    //let cellId = "cellid"
    
//    let carouselImages = [UIColor.yellow, UIColor.green, UIColor.red, UIColor.yellow, UIColor.green]
    let navigationName = ["School", "Work", "Leisure"]
    var homePostCell: HomePostCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = UIColor(r: 238, g: 238, b: 244)
//        collectionView?.backgroundColor = UIColor.lightGray
        setupHomeHeaderBar()
        
        collectionView?.register(HomeCarouselCell.self, forCellWithReuseIdentifier: "carouselCellId")
        collectionView?.register(HomeNavigationCell.self, forCellWithReuseIdentifier: "navigationCellId")
        collectionView?.register(HomePostCell.self, forCellWithReuseIdentifier: "postCellId")
        
        fetchPosts()
        fetchCarouselImages()
    }
    
    var carouselImageUrls: [String]?
    func fetchCarouselImages(){
        let databaseRef = Database.database().reference()
        let databaseCarouselImages = databaseRef.child("carouselImageUrl")
        databaseCarouselImages.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let array = snapshot.value as? [String] else {return}
            self.carouselImageUrls = Array(repeating: "nil", count: array.count + 2)
            for i in 0..<array.count + 2 {
                if i == 0 {
                    self.carouselImageUrls?[i] = array[array.count - 1]
                }else if i == array.count + 1 {
                    self.carouselImageUrls?[i] = array[0]
                }else {
                    self.carouselImageUrls?[i] = array[i - 1]
                }
            }
            self.collectionView?.reloadData()
        }){ (error) in
            print("Failed to fetch carousels", error)
        }
    }
    
    var posts = [Post]()
    func fetchPosts(){
//        guard let uid = Auth.auth().currentUser?.uid else {return}
        Database.fetchUserWithUID(uid: "fqmXu9io3iaUOvMPDEvfiLYH1dv1") { (user) in
            self.fetchPostWithUser(user: user)
        }
    }
    
    func fetchPostWithUser(user: User){
        let databaseRef = Database.database().reference()
        let databasePosts = databaseRef.child("posts").child(user.uid)
        databasePosts.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let dictionary = snapshot.value as? [String: Any] else {return}
            dictionary.forEach({ (key, value) in
                guard let dictionary = value as? [String: Any] else {return}
                let post = Post(user: user, dictionary: dictionary)
                //                    self.posts.insert(post, at: 0)
                self.posts.append(post)
            })
            self.collectionView?.reloadData()
        }) { (error) in
            print("Failed to fetch posts", error)
        }
    }
    
    func setupHomeHeaderBar(){
        navigationItem.title = "Yi Zheng (Amy)"
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 1 {
            return 3
        }else if section == 2 {
            return posts.count
        }
        return 1
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "carouselCellId", for: indexPath) as! HomeCarouselCell
            //cell.backgroundColor = .yellow
            cell.carouselImageUrls = self.carouselImageUrls
            return cell
        }else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "navigationCellId", for: indexPath) as! HomeNavigationCell
            //cell.backgroundColor = .red
            //cell.homeController = self
            cell.navImage.image = UIImage(named: navigationName[indexPath.item])?.withRenderingMode(.alwaysOriginal)
            cell.navLabel.text = navigationName[indexPath.item]
            return cell
        }else {
            homePostCell = collectionView.dequeueReusableCell(withReuseIdentifier: "postCellId", for: indexPath) as? HomePostCell
            //cell.backgroundColor = .black
            homePostCell?.post = posts[indexPath.item]
            
            homePostCell?.delegate = self
            return homePostCell!
        }
    }
    
    func didTapComment(post: Post) {
        let layout = UICollectionViewFlowLayout()
        let commentsController = CommentsController(collectionViewLayout: layout)
        
        navigationController?.pushViewController(commentsController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {// Carousel section
            return CGSize(width: view.frame.width, height: 200)
        }else if indexPath.section == 1 {// Navigation Bar
//            UIButton solution
//            return CGSize(width: view.frame.width, height: 120)
            return CGSize(width: view.frame.width / 3, height: 120)
        }else if indexPath.section == 2 {// Post section
            return CGSize(width: view.frame.width, height: view.frame.width + 50 + 80)
        }
        return CGSize(width: view.frame.width, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if section == 1 {
            return 0
        }else {
            return 18
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            homeNavigation(index: indexPath.item)
        }
    }
    
    //Post section header
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        collectionView.register(HomePostHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerId")
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerId", for: indexPath) as! HomePostHeaderCell
        header.homePostCell = self.homePostCell
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 2 {
            return CGSize(width: view.frame.width, height: 50)
        }
        return CGSize(width: 0, height: 0)
    }
    
//    func scrollToPostHeaderIndex(index: Int){
//        let indexPath = IndexPath(item: index, section: 0)
//    }
    
    func homeNavigation(index: Int){
        let layout = UICollectionViewFlowLayout()
        let postController = PostController(collectionViewLayout: layout)
        navigationController?.pushViewController(postController, animated: true)
        if index == 0 {
            postController.navigationItem.title = "School"
        }else if index == 1 {
            postController.navigationItem.title = "Work"
        }else {
            postController.navigationItem.title = "Leisure"
        }
    }
}
