//
//  ViewController.swift
//  ReactionGame
//
//  Created by Ralph Cachero on 10/16/15.
//  Copyright © 2015 Teradek. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var timer = NSTimer()
    var timerscore = NSTimer()
    
    var countInt = 0
    var scoreInt = 0

    @IBOutlet weak var getReadyLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var Start: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        scoreInt = 0
        timerLabel.text = String(scoreInt)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func StartStop(sender: UIButton) {
        
        if scoreInt == 0 {
            countInt = 3
            getReadyLabel.text = String(countInt)
            timerLabel.text = String(scoreInt)
            
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("updateCounter"), userInfo: nil, repeats: true)
            
            sender.setTitle("Start", forState: UIControlState.Normal)

            
        } else {
            timerscore.invalidate()
        }
        
        if countInt == 0 {
            scoreInt = 0
            
            sender.setTitle("Restart", forState: UIControlState.Normal)
        }
        
    }
    
    func updateCounter(){
        countInt -= 1
        getReadyLabel.text = String(countInt)
        
        if countInt == 0 {
            timer.invalidate()
            
            scoreInt = 0
            timerLabel.text = String(scoreInt)
            
            timerscore = NSTimer.scheduledTimerWithTimeInterval(0.0001, target: self, selector: Selector("updateScoreTimer"), userInfo: nil, repeats: true)
            
            Start.setTitle("Stop", forState: UIControlState.Normal)
        }
    }
    
    func updateScoreTimer(){
        scoreInt += 1
        timerLabel.text = String(scoreInt)
    }
    

}

