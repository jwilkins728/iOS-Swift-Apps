//
//  PhotoVC.swift
//  myFavoritePlace
//
//  Created by Ralph Cachero on 1/15/16.
//  Copyright © 2016 Teradek. All rights reserved.
//

import UIKit

class PhotoVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func backPressed(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
