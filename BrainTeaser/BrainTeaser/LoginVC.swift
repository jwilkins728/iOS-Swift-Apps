//
//  ViewController.swift
//  BrainTeaser
//
//  Created by Ralph Cachero on 3/13/16.
//  Copyright © 2016 Teradek. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    
    @IBOutlet weak var emailConstraint: NSLayoutConstraint!
    @IBOutlet weak var passwordConstraint: NSLayoutConstraint!
    @IBOutlet weak var loginConstraint: NSLayoutConstraint!
    
    var animEngine: AnimationEngine!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.animEngine = AnimationEngine(constraints: [emailConstraint, passwordConstraint, loginConstraint])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(animated: Bool) {
        self.animEngine.animateOnScreen(1)
    }

}

