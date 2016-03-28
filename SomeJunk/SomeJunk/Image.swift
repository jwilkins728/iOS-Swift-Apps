//
//  Image.swift
//  SomeJunk
//
//  Created by Ralph Cachero on 3/20/16.
//  Copyright © 2016 Teradek. All rights reserved.
//

import UIKit
import CoreData


class Image: NSManagedObject {

    func setItemImage(img: UIImage) {
        self.image = img
    }
    
    func getItemImg() -> UIImage {
        if let img = self.image as? UIImage {
            return img
        }
        return UIImage(named: "filler")!
    }

}
