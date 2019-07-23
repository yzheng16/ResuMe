//
//  MeCell.swift
//  ResuMe
//
//  Created by Yi Zheng on 2019-07-22.
//  Copyright © 2019 Yi Zheng. All rights reserved.
//

import UIKit

class MeCell: UICollectionViewCell {
    
    var post: PostREST? {
        didSet {
            guard let title = post?.title else { return }
            titleLable.text = title
            guard let body = post?.body else { return }
            bodyLable.text = body
        }
    }
    
    let titleLable: UILabel = {
        let l = UILabel()
        l.text = "TestTitle"
        return l
    }()
    
    let bodyLable: UILabel = {
        let l = UILabel()
        l.text = "TestBody"
        return l
    }()
    
    let deleteButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("Delete", for: .normal)
        b.setTitleColor(.red, for: .normal)
        return b
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(titleLable)
        addSubview(bodyLable)
        addSubview(deleteButton)
        
        titleLable.anchor(topAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 8, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        bodyLable.anchor(titleLable.bottomAnchor, left: titleLable.leftAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        deleteButton.anchor(nil, left: nil, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 10, rightConstant: 8, widthConstant: 0, heightConstant: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
