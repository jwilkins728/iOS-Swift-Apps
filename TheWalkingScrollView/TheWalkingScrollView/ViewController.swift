//
//  ViewController.swift
//  TheWalkingScrollView
//
//  Created by Ralph Cachero on 1/18/16.
//  Copyright © 2016 Teradek. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    let WIDTH: CGFloat = 240
    let HEIGHT: CGFloat = 397

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for var x = 1; x <= 5; x++ {
            let img = UIImage(named: "\(x)")!
            let imgView = UIImageView(image: img)
            
            scrollView.addSubview(imgView)
            
            imgView.frame = CGRectMake(-WIDTH + (WIDTH * CGFloat(x)), 175, WIDTH, HEIGHT)
        }
        
        scrollView.contentSize = CGSizeMake(WIDTH * 5, scrollView.frame.size.height)
        
    }

    
}

