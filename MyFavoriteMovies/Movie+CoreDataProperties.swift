//
//  Movie+CoreDataProperties.swift
//  MyFavoriteMovies
//
//  Created by Ralph Cachero on 1/21/16.
//  Copyright © 2016 Teradek. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Movie {

    @NSManaged var image: NSData?
    @NSManaged var title: String?
    @NSManaged var year: String?
    @NSManaged var plot: String?
    @NSManaged var reason: String?
    @NSManaged var link: String?

}
