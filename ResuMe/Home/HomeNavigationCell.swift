//
//  HomeNavigationCell.swift
//  ResuMe
//
//  Created by Yi Zheng on 2019-01-02.
//  Copyright © 2019 Yi Zheng. All rights reserved.
//

import UIKit

class HomeNavigationCell: UICollectionViewCell {
    
    //var homeController: HomeController?
    var navigationName: [String]?
    
    let navImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.widthAnchor.constraint(equalToConstant: 56).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 56).isActive = true
        //iv.image = UIImage(named: "school64")?.withRenderingMode(.alwaysOriginal)
        return iv
    }()
    
    let navLabel: UILabel = {
        let l = UILabel()
        //l.text = "School"
        l.textAlignment = .center
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        
        let stackView = UIStackView(arrangedSubviews: [navImage, navLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        //stackView.spacing = 10
        addSubview(stackView)
        stackView.anchorCenterSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

