//
//  HomeController.swift
//  ResuMe
//
//  Created by Yi Zheng on 2019-01-02.
//  Copyright © 2019 Yi Zheng. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    let cellId = "cellid"
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHomeHeaderBar()
        collectionView?.backgroundColor = .white
        
        
    }
    
    func setupHomeHeaderBar(){
        navigationItem.title = "Yi Zheng (Amy)"
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            collectionView.register(HomeCarouselCell.self, forCellWithReuseIdentifier: cellId)
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomeCarouselCell
            //cell.backgroundColor = .yellow
            return cell
        }else if indexPath.section == 1 {
            collectionView.register(HomeNavigationCell.self, forCellWithReuseIdentifier: cellId)
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomeNavigationCell
            //cell.backgroundColor = .red
            return cell
        }else if indexPath.section == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
            cell.backgroundColor = .black
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        cell.backgroundColor = .yellow
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {// Carousel section
            return CGSize(width: view.frame.width, height: 200)
        }else if indexPath.section == 1 {// Navigation Bar
            return CGSize(width: view.frame.width, height: 120)
        }else if indexPath.section == 2 {// Post section
            // test 1 post
            return CGSize(width: view.frame.width, height: view.frame.width + 50 + 80)
        }
        return CGSize(width: view.frame.width, height: 250)
    }
    
    //Post section header
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        collectionView.register(HomePostHeaderCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerid")
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerid", for: indexPath) as! HomePostHeaderCell
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 2 {
            return CGSize(width: view.frame.width, height: 50)
        }
        return CGSize(width: 0, height: 0)
    }
}
