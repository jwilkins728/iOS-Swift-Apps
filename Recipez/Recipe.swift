//
//  Recipe.swift
//  Recipez
//
//  Created by Ralph Cachero on 1/20/16.
//  Copyright © 2016 Teradek. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class Recipe: NSManagedObject {

// Insert code here to add functionality to your managed object subclass

    func setRecipeImage(img: UIImage) {
        let data = UIImageJPEGRepresentation(img, 0.8)
        self.image = data
    }
    
    func getRecipeImg() -> UIImage {
        let img = UIImage(data: self.image!)!
        return img
    }
    
}
