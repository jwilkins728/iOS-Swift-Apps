//
//  ItemCell.swift
//  SomeJunk
//
//  Created by Ralph Cachero on 3/20/16.
//  Copyright © 2016 Teradek. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet weak var thumb: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var details: UILabel!

    func configureCell(item: Item) {
        title.text = item.title
        price.text = "$\(item.price!)"
        details.text = item.details
        
        if let image = item.image?.getItemImg() {
            thumb.image = image
        }
        
    }
}
