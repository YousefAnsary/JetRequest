//
//  JetImage.swift
//  JetRequest
//
//  Created by Yousef on 11/20/20.
//  Copyright © 2020 Yousef. All rights reserved.
//

import Foundation

public class JetImage {
    
    private static let imageCache = NSCache<AnyObject, UIImage>()
    
    public static func downloadImage(url: String, completion: @escaping (UIImage?)-> Void) {
        guard let urlObject = URL(string: url) else {return}
        DispatchQueue.global(qos: .userInitiated).async {
            JetRequest.urlSession.dataTask(with: urlObject) { data, res, err in
                guard let data = data, err == nil else {print("Err Fetching data from \(url)"); return}
                DispatchQueue.main.async {
                    completion(UIImage(data: data))
                }// End DispatchQueue main closure
            }.resume() //End data task closure
        }// End DispatchQueue userInitiated closure
    }
    
    public static func clearCache(forUrl url: String) {
        imageCache.removeObject(forKey: url as AnyObject)
    }
    
    public static func clearCache() {
        imageCache.removeAllObjects()
    }
    
    internal static func cache(image: UIImage, url: String) {
        imageCache.setObject(image, forKey: url as AnyObject)
    }
    
    internal static func cachedImage(forUrl url: String)-> UIImage? {
        return imageCache.object(forKey: url as AnyObject)
    }
    
}
