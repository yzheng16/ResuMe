//
//  PostController.swift
//  ResuMe
//
//  Created by Yi Zheng on 2019-01-05.
//  Copyright © 2019 Yi Zheng. All rights reserved.
//

import UIKit

class PostController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postCellId", for: indexPath) as! PostCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.width + 50 + 80)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = UIColor(r: 238, g: 238, b: 244)
        
        collectionView?.register(PostCell.self, forCellWithReuseIdentifier: "postCellId")
    }
}
