//
//  UIImageView+JetRequest.swift
//  JetRequest
//
//  Created by Yousef on 10/8/20.
//  Copyright © 2020 Yousef. All rights reserved.
//

import UIKit

public extension UIImageView {
    
    func loadImage(fromUrl url: String, defaultImage: UIImage? = nil, showActivityIndicator: Bool = true,
                   activityIndicatorStyle: UIActivityIndicatorView.Style = .gray) {
        if let cacheImage = JetRequest.imageCache.object(forKey: url as AnyObject) {
            self.image = cacheImage
            return
        }
        
        let activityIndicator = UIActivityIndicatorView(style: activityIndicatorStyle)
        activityIndicator.frame = self.frame
        activityIndicator.hidesWhenStopped = true
        if showActivityIndicator { activityIndicator.startAnimating() }
        
        JetRequest.downloadImage(url: url) { image in
            if showActivityIndicator { activityIndicator.stopAnimating() }
            guard let image = image else {self.image = defaultImage; return}
            JetRequest.imageCache.setObject(image, forKey: url as AnyObject)
            self.image = image
        }
    }
    
}
