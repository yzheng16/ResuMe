//
//  HomePostCell.swift
//  ResuMe
//
//  Created by Yi Zheng on 2019-01-03.
//  Copyright © 2019 Yi Zheng. All rights reserved.
//

import UIKit

protocol HomePostCellDelegate {
    func didTapComment(post: Post)
}

class HomePostCell: UICollectionViewCell {
    
    var delegate: HomePostCellDelegate?
    
    var post: Post?{
        didSet{
            guard let imageUrl = post?.imageUrl else {return}
            photoImageView.loadImage(urlString: imageUrl)
//            guard let user = post?.user else {return}
//            photoImageView.loadImage(urlString: user.profileImageUrl)
//            username.text = user.username
            setupCaption()
        }
    }
    
    func setupCaption(){
        guard let post = self.post else {return}
        let attributedText = NSMutableAttributedString(string: "\(post.user.username) ", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: "\(post.caption)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]))
        attributedText.append(NSAttributedString(string: "\n\n", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 5)]))
        attributedText.append(NSAttributedString(string: "1 week ago", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]))
        captionLabel.attributedText = attributedText
    }
    
    let photoImageView: CustomImageView = {
        let civ = CustomImageView()
        civ.contentMode = .scaleAspectFill
        civ.clipsToBounds = true
        return civ
    }()
    
    let likeButton: UIButton = {
        let b = UIButton(type: .system)
        b.setImage(#imageLiteral(resourceName: "like_unselected").withRenderingMode(.alwaysOriginal), for: .normal)
        return b
    }()
    
    lazy var commentButton: UIButton = {
        let b = UIButton(type: .system)
        b.setImage(#imageLiteral(resourceName: "comment").withRenderingMode(.alwaysOriginal), for: .normal)
        b.addTarget(self, action: #selector(handleComment), for: .touchUpInside)
        return b
    }()
    
    @objc func handleComment() {
        print("trying to show comments")
        guard let post = self.post else {return}
        delegate?.didTapComment(post: post)
    }
    
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
        buttonStackView.anchor(photoImageView.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 8, bottomConstant: 0, rightConstant: 0, widthConstant: 80, heightConstant: 50)
        
        addSubview(captionLabel)
        captionLabel.anchor(likeButton.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 8, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
