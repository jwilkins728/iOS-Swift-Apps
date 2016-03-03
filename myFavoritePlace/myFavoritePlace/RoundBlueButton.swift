//
//  RoundBlueButton.swift
//  myFavoritePlace
//
//  Created by Ralph Cachero on 1/10/16.
//  Copyright © 2016 Teradek. All rights reserved.
//

import UIKit

class RoundBlueButton: UIButton {
    
    override func awakeFromNib() {
        layer.cornerRadius = 2.0
        backgroundColor = UIColor(red: 30.0/255.0, green: 200.0/255.0, blue: 195.0/255.0, alpha: 0.7)
        setTitleColor(UIColor.whiteColor(), forState: .Normal)
    }

}
