//
//  Movie.swift
//  MyFavoriteMovies
//
//  Created by Ralph Cachero on 1/21/16.
//  Copyright © 2016 Teradek. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class Movie: NSManagedObject {
    
    func setMovieImg(img: UIImage) {
        let data = UIImageJPEGRepresentation(img, 0.7)
        self.image = data
    }
    
    func getMovieImg() -> UIImage {
        let img = UIImage(data: self.image!)!
        return img
    }

}
