//
//  User.swift
//  ResuMe
//
//  Created by Yi Zheng on 2019-01-04.
//  Copyright © 2019 Yi Zheng. All rights reserved.
//

import Foundation

struct User {
    let uid: String
    let username: String
//    let profileImageUrl: String
    
    init(uid: String, dictionary:[String:Any]) {
        self.uid = uid
        self.username = dictionary["username"] as! String
//        self.profileImageUrl = dictionary["profileImageUrl"] as! String
    }
}
