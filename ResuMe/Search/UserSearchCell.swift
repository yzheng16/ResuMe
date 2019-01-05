//
//  UserSearchCell.swift
//  ResuMe
//
//  Created by Yi Zheng on 2019-01-04.
//  Copyright © 2019 Yi Zheng. All rights reserved.
//

import UIKit

class UserSearchCell: UICollectionViewCell {
    
    var user: User?{
        didSet{
            username.text = user?.username
        }
    }
    
    let username: UILabel = {
        let l = UILabel()
        l.text = "Username"
        return l
    }()
    
    let separatorLineView: UIView = {
        let v = UIView()
        v.backgroundColor = .gray
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(username)
        addSubview(separatorLineView)
        
        username.anchorCenterSuperview()
        separatorLineView.anchor(bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 16, bottomConstant: 0, rightConstant: 16, widthConstant: 0, heightConstant: 0.5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
