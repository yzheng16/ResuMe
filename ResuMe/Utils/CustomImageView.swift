//
//  CustomImageView.swift
//  ResuMe
//
//  Created by Yi Zheng on 2019-01-01.
//  Copyright © 2019 Yi Zheng. All rights reserved.
//

import UIKit

var imageCache = [String: UIImage]()

class CustomImageView: UIImageView {
    
    var lastURLUsedToLoadImage: String?
    
    func loadImage(urlString: String) {
        lastURLUsedToLoadImage = urlString
        
        //only fetching image once
        //if the image is already in the imageCache, system won't fetch it again from network
        if let cachedImage = imageCache[urlString] {
            self.image = cachedImage
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let err = err {
                print("Failed to fetch post image:", err)
                return
            }
            
            //insure all the image are different.
            //because system will call reloadView twice which is from carousel and post
            //why it happens? rul can be differnet. Because it is URLSession is async. Some images are big, some are small
            if url.absoluteString != self.lastURLUsedToLoadImage {
                return
            }
            
            guard let imageData = data else { return }
            
            let photoImage = UIImage(data: imageData)
            
            imageCache[url.absoluteString] = photoImage
            
            DispatchQueue.main.async {
                self.image = photoImage
            }
            
            }.resume()
    }
}
