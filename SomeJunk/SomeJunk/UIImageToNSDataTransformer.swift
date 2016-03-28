//
//  UIImageToNSDataTransformer.swift
//  SomeJunk
//
//  Created by Ralph Cachero on 3/25/16.
//  Copyright © 2016 Teradek. All rights reserved.
//

import UIKit

class UIImageToNSDataTransformer: NSValueTransformer {

    override class func transformedValueClass() -> AnyClass {
        return NSData.self
    }
    
    override class func allowsReverseTransformation() -> Bool {
        return true
    }
    
    override func transformedValue(value: AnyObject?) -> AnyObject? {
        // takes UIImage and returns it as NSData
        if let value = value as? UIImage {
            let imageData: NSData = UIImagePNGRepresentation(value)!
            return imageData
        }
        return nil
    }
    
    override func reverseTransformedValue(value: AnyObject?) -> AnyObject? {
        // takes data and returns it as a UIImage
        if let value = value as? NSData {
            let image: UIImage = UIImage(data: value)!
            return image
        }
        return nil
    }
    
}
