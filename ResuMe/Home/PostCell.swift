//
//  PostCell.swift
//  ResuMe
//
//  Created by Yi Zheng on 2019-01-05.
//  Copyright © 2019 Yi Zheng. All rights reserved.
//

import UIKit

class PostCell: UICollectionViewCell {
    
    let photoImageView: CustomImageView = {
        let civ = CustomImageView()
        civ.contentMode = .scaleAspectFill
        civ.clipsToBounds = true
        civ.backgroundColor = .green
        return civ
    }()
    
    let likeButton: UIButton = {
        let b = UIButton(type: .system)
        b.setImage(#imageLiteral(resourceName: "like_unselected").withRenderingMode(.alwaysOriginal), for: .normal)
        return b
    }()
    
    let commentButton: UIButton = {
        let b = UIButton(type: .system)
        b.setImage(#imageLiteral(resourceName: "comment").withRenderingMode(.alwaysOriginal), for: .normal)
        return b
    }()
    
    let captionLabel: UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(photoImageView)
        photoImageView.anchor(topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: frame.width)
        
        let buttonStackView = UIStackView(arrangedSubviews: [likeButton, commentButton])
        buttonStackView.distribution = .fillEqually
        addSubview(buttonStackView)
        buttonStackView.anchor(photoImageView.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: 8, leftConstant: 8, bottomConstant: 0, rightConstant: 0, widthConstant: 80, heightConstant: 50)
        
        addSubview(captionLabel)
        captionLabel.anchor(likeButton.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 8, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

