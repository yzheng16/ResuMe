//
//  SelectCategoryController.swift
//  ResuMe
//
//  Created by Yi Zheng on 2019-05-10.
//  Copyright © 2019 Yi Zheng. All rights reserved.
//

import UIKit

class SelectCateoryController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .blue
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
