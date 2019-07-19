//
//  Post.swift
//  ResuMe
//
//  Created by Yi Zheng on 2019-04-19.
//  Copyright © 2019 Yi Zheng. All rights reserved.
//

import Foundation

struct Post {
    var id: String?
    var imageUrl: String
    var user: User
    var caption: String
    let creationDate: Date
    
    init(user: User, dictionary: [String: Any]) {
        self.user = user
        imageUrl = dictionary["postImageUrl"] as? String ?? ""
        caption = dictionary["caption"] as? String ?? ""
        let secondsFrom1970 = dictionary["creationDate"] as? Double ?? 0
        self.creationDate = Date(timeIntervalSince1970: secondsFrom1970)
    }
}
