//
//  MeController.swift
//  ResuMe
//
//  Created by Yi Zheng on 2019-05-10.
//  Copyright © 2019 Yi Zheng. All rights reserved.
//

import UIKit

class MeController: UIViewController {
    
    let lable: UILabel = {
        let l = UILabel()
        l.text = "Coming soon"
        l.textAlignment = .center
        return l
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(lable)
        
        lable.fillSuperview()
    }
}
