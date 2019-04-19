//
//  DatabaseUtil.swift
//  ResuMe
//
//  Created by Yi Zheng on 2019-04-19.
//  Copyright © 2019 Yi Zheng. All rights reserved.
//

import Foundation
import Firebase

extension Database {
    static func fetchUserWithUID(uid: String, completion: @escaping (User) -> ()){
        let databaseRef = Database.database().reference()
        
        let databaseUsers = databaseRef.child("users").child(uid)
        databaseUsers.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let dictionary = snapshot.value as? [String: Any] else {return}
            let user = User(uid: uid, dictionary: dictionary)
            
            completion(user)
        }) { (error) in
            print("failed to fetch user", error)
        }
    }
}
