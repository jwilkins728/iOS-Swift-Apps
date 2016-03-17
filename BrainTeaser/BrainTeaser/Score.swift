//
//  Score.swift
//  BrainTeaser
//
//  Created by Ralph Cachero on 3/15/16.
//  Copyright © 2016 Teradek. All rights reserved.
//

import UIKit

class Score: UIView {
    
    @IBOutlet weak var correctScore: UILabel!
    @IBOutlet weak var incorrectScore: UILabel!
    @IBOutlet weak var totalScore: UILabel!
    
    @IBInspectable var cornerRadius: CGFloat = 3.0 {
        didSet {
            setupView()
        }
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
    override func awakeFromNib() {
        setupView()
        
    }

    func setupView() {
        self.layer.cornerRadius = cornerRadius
        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = 5.0
        self.layer.shadowOffset = CGSizeMake(0.0, 2.0)
        self.layer.shadowColor = UIColor(red: 157.0/255.0, green: 157.0/255.0, blue: 157.0/255.0, alpha: 1.0).CGColor
        self.setNeedsLayout()
    }
}
