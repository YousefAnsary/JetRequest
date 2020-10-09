//
//  UIImage+JetRequest.swift
//  JetRequest
//
//  Created by Yousef on 10/8/20.
//  Copyright © 2020 Yousef. All rights reserved.
//

import UIKit

extension UIImage {
    
//    func resizeByByte(maxByte: Int)-> Data? {
//        
//        let simaphore = DispatchSemaphore(value: 0)
//        var compressQuality: CGFloat = 0.9
//        guard var jpegData = self.jpegData(compressionQuality: compressQuality) else {return nil}
//        var imageByte = jpegData.count
//        
//        DispatchQueue.global(qos: .background).async {
//            while imageByte > maxByte {
//                jpegData = self.jpegData(compressionQuality: compressQuality)!
//                imageByte = jpegData.count
//                guard compressQuality > 0.2 else {break}
//                compressQuality -= 0.1
//            }
//            simaphore.signal()
//        }
//        simaphore.wait()
//        return jpegData
//    }
    
}
