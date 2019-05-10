//
//  PostController.swift
//  ResuMe
//
//  Created by Yi Zheng on 2019-01-05.
//  Copyright © 2019 Yi Zheng. All rights reserved.
//

import UIKit
import Firebase

class PostController: UICollectionViewController, UICollectionViewDelegateFlowLayout, HomePostCellDelegate {
    func didTapComment(post: Post) {
        let layout = UICollectionViewFlowLayout()
        let commentsController = CommentsController(collectionViewLayout: layout)
        commentsController.post = post
        
        navigationController?.pushViewController(commentsController, animated: true)
    }
    
    
    var homePostCell: HomePostCell?
    
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
                var post = Post(user: user, dictionary: dictionary)
                post.id = key
                //                    self.posts.insert(post, at: 0)
                self.posts.append(post)
            })
            self.collectionView?.reloadData()
        }) { (error) in
            print("Failed to fetch posts", error)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postCellId", for: indexPath) as! HomePostCell
        cell.post = posts[indexPath.item]
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.width + 50 + 80)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = UIColor(r: 238, g: 238, b: 244)
        
        collectionView?.register(HomePostCell.self, forCellWithReuseIdentifier: "postCellId")
        
        fetchPosts()
    }
}
