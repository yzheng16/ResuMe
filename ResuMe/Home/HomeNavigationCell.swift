//
//  HomeNavigationCell.swift
//  ResuMe
//
//  Created by Yi Zheng on 2019-01-02.
//  Copyright © 2019 Yi Zheng. All rights reserved.
//

import UIKit

class HomeNavigationCell: UICollectionViewCell {
    
    var homeController: HomeController?
    
    let schoolButton: UIButton = {
        let b = UIButton(type: .system)
        b.setImage(#imageLiteral(resourceName: "school64").withRenderingMode(.alwaysOriginal), for: .normal)
        b.setTitle("School", for: .normal)
        b.tintColor = .black
        b.alignTextBelow()
        b.addTarget(self, action: #selector(handleSchoolButton), for: .touchUpInside)
        return b
    }()
    
    let workButton: UIButton = {
        let b = UIButton(type: .system)
        b.setImage(#imageLiteral(resourceName: "work64").withRenderingMode(.alwaysOriginal), for: .normal)
        b.setTitle("Work", for: .normal)
        b.tintColor = .black
        b.alignTextBelow()
        b.addTarget(self, action: #selector(handleWorkButton), for: .touchUpInside)
        return b
    }()
    
    let leisureButton: UIButton = {
        let b = UIButton(type: .system)
        b.setImage(#imageLiteral(resourceName: "leisure64").withRenderingMode(.alwaysOriginal), for: .normal)
        b.setTitle("Leisure", for: .normal)
        b.tintColor = .black
        b.alignTextBelow()
        b.addTarget(self, action: #selector(handleLeisureButton), for: .touchUpInside)
        return b
    }()
    
    @objc func handleSchoolButton(){
        print("123")
        homeController?.homeNavigation(index: 0)
    }
    
    @objc func handleWorkButton(){
        homeController?.homeNavigation(index: 1)
    }
    
    @objc func handleLeisureButton(){
        homeController?.homeNavigation(index: 2)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        let stackView = UIStackView(arrangedSubviews: [schoolButton, workButton, leisureButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
        stackView.fillSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension UIButton {
    
    func alignTextBelow(spacing: CGFloat = 6.0) {
        if let image = self.imageView?.image {
            let imageSize: CGSize = image.size
            self.titleEdgeInsets = UIEdgeInsetsMake(spacing, -imageSize.width, -(imageSize.height), 0.0)
            let labelString = NSString(string: self.titleLabel!.text!)
            let titleSize = labelString.size(withAttributes: [NSAttributedStringKey.font: self.titleLabel!.font])
            self.imageEdgeInsets = UIEdgeInsetsMake(-(titleSize.height + spacing), 0.0, 0.0, -titleSize.width)
        }
    }
    
}
