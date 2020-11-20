//
//  UIImageView+JetRequest.swift
//  JetRequest
//
//  Created by Yousef on 10/8/20.
//  Copyright © 2020 Yousef. All rights reserved.
//

import UIKit

public extension UIImageView {
    
    func loadImage(fromUrl url: String, defaultImage: UIImage? = nil, completion: ((_ success: Bool, _ isCached: Bool)-> Void)? = nil) {
        if let cacheImage = JetImage.cachedImage(forUrl: url) {
            self.image = cacheImage
            completion?(true, true)
            return
        }
        
        JetImage.downloadImage(url: url) { image in
            guard let image = image else {self.image = defaultImage; completion?(false, false); return}
            JetImage.cache(image: image, url: url)
            self.image = image
            completion?(true, false)
        }
    }
    
}
