//
//  Comment.swift
//  ResuMe
//
//  Created by Yi Zheng on 2019-05-08.
//  Copyright © 2019 Yi Zheng. All rights reserved.
//

import Foundation

struct Comment {
    
    let user: User
    let text: String
    let uid: String
    
    init(user: User, dictionary: [String: Any]) {
        self.user = user
        self.text = dictionary["text"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
    }
}
