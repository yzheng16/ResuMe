//
//  MeController.swift
//  ResuMe
//
//  Created by Yi Zheng on 2019-05-10.
//  Copyright © 2019 Yi Zheng. All rights reserved.
//

import UIKit

struct PostREST: Decodable {
    let id: Int
    let title, body: String
}

class Service: NSObject {
    //Singleton: don't need to declare it. Just use it
    static let shared = Service()
    
    func fetchPosts(completion: @escaping (Result<[PostREST], Error>) -> ()) {
        //TODO: Add error hangler for the server is not runing
        guard let url = URL(string: "http://Localhost:1337/posts") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            DispatchQueue.main.async {
                if let err = err {
                    print("Failed to fetch posts: ", err)
                    return
                }
                
                guard let data = data else { return }
                do {
                    let posts = try JSONDecoder().decode([PostREST].self, from: data)
                    completion(.success(posts))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    func createPost(title: String, body: String, completion: @escaping (Error?) -> ()) {
        guard let url = URL(string: "http://Localhost:1337/post") else { return }
        var urlRequest = URLRequest(url: url)
        let params = ["title": title, "postBody": body]
        
        do {
            let data = try JSONSerialization.data(withJSONObject: params, options: .init())
            
            urlRequest.httpMethod = "POST"
            urlRequest.httpBody = data
            urlRequest.setValue("application/json", forHTTPHeaderField: "content-type")
                
            URLSession.shared.dataTask(with: urlRequest) { (data, resp, err) in
                if let err = err {
                    completion(err)
                    return
                }
                completion(nil)
            }.resume()
        } catch {
            completion(error)
        }
    }
    
    func deletePost(id: Int, completion: @escaping (Error?) -> ()) {
        guard let url = URL(string: "http://Localhost:1337/post/\(id)") else { return }
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: urlRequest) { (data, resp, err) in
            if let err = err {
                completion(err)
                return
            }
            completion(nil)
        }.resume()
    }
}

class MeController: UICollectionViewController, UICollectionViewDelegateFlowLayout, MeCellDeleget {
    
    var posts = [PostREST]()
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        
        setUpHeaderBar()
        
        collectionView.register(MeCell.self, forCellWithReuseIdentifier: cellId)
        
        fetchPosts()
    }
    
    func setUpHeaderBar() {
        navigationItem.title = "REST API Implementation"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Create Post", style: .plain, target: self, action: #selector(handleCreatPost))
    }
    
    @objc fileprivate func handleCreatPost(){
        Service.shared.createPost(title: "New Title", body: "New body") { (err) in
            if let err = err {
                print("Failed to create post object: ", err)
                return
            }
            
            print("Finished creating post")
            self.fetchPosts()
        }
    }
    
    fileprivate func fetchPosts() {
        Service.shared.fetchPosts { (res) in
            switch res {
            case .failure(let err):
                print("Failed to fetch posts: ", err)
            case .success(let posts):
                self.posts = posts
                self.collectionView.reloadData()
            }
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
//        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MeCell
//        cell.backgroundColor = .yellow
        cell.post = posts[indexPath.item]
        cell.deleget = self
        return cell
    }
    
    func didTapDelete(post: PostREST) {
        Service.shared.deletePost(id: post.id) { (err) in
            if let err = err {
                print("Failed to delete post object: ", err)
                return
            }
        }
        print("Finshed deleting post")
        
        guard let index = self.posts.firstIndex(where: {$0.id == post.id}) else { return }
        self.posts.remove(at: index)
        self.collectionView.reloadData()
        //Can not simply call fetchPosts function. Because system uses more time to delete, system won't get back the
        //right posts list from server
//        self.fetchPosts()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
}
