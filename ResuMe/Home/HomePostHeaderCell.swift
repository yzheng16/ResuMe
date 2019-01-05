//
//  HomePostHeaderCell.swift
//  ResuMe
//
//  Created by Yi Zheng on 2019-01-02.
//  Copyright © 2019 Yi Zheng. All rights reserved.
//

import UIKit

class HomePostHeaderCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let headerTitle = ["School", "Career"]
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    let separatorTopBar: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(r: 215, g: 216, b: 218)
        return v
    }()
    
    let separatorBottomBar: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(r: 99, g: 149, b: 224)
        return v
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostHeaderCellId", for: indexPath) as! HeaderTitleCell
        cell.title.text = headerTitle[indexPath.item]
        cell.title.textColor = UIColor(r: 187, g: 187, b: 187)
        //default selected item
        let selectedIndexPathDefault = NSIndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedIndexPathDefault as IndexPath, animated: false, scrollPosition: .top)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 2, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(separatorTopBar)
        addSubview(collectionView)
        addSubview(separatorBottomBar)
        
        separatorTopBar.anchor(topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 1)
        collectionView.anchor(separatorTopBar.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 50)
        separatorBottomBar.anchor(nil, left: leftAnchor, bottom: bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: frame.width / 2, heightConstant: 4)
        
        collectionView.register(HeaderTitleCell.self, forCellWithReuseIdentifier: "PostHeaderCellId")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class HeaderTitleCell: UICollectionViewCell {
    
    let title: UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.font = UIFont.systemFont(ofSize: 16)
        return l
    }()
    
    override var isHighlighted: Bool{
        didSet{
            title.textColor = isHighlighted ? UIColor.black : UIColor(r: 187, g: 187, b: 187)
        }
    }
    
    override var isSelected: Bool{
        didSet{
            title.textColor = isSelected ? UIColor.black : UIColor(r: 187, g: 187, b: 187)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(title)
        title.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 5, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
