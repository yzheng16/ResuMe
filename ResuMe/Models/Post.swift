//
//  Post.swift
//  ResuMe
//
//  Created by Yi Zheng on 2019-04-19.
//  Copyright © 2019 Yi Zheng. All rights reserved.
//

import Foundation

struct Post {
    var imageUrl: String
    var user: User
    var caption: String
    
    init(user: User, dictionary: [String: Any]) {
        self.user = user
        imageUrl = dictionary["postImageUrl"] as? String ?? ""
        caption = dictionary["caption"] as? String ?? ""
    }
}
