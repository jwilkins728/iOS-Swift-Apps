//
//  ViewController.swift
//  Multiples
//
//  Created by Ralph Cachero on 12/21/15.
//  Copyright © 2015 Teradek. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    //Properties
    var multiple = 0
    var count = 0
    var prevSum = 0
    var sum = 0
    
    //Outlets
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var multipleTxt: UITextField!
    @IBOutlet weak var playBtn: UIButton!
    
    @IBOutlet weak var multipleEqn: UILabel!
    @IBOutlet weak var addBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.multipleTxt.delegate = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onPlayBtnPressed(sender: UIButton) {
        if multipleTxt.text != nil && multipleTxt.text != "" {
            
            logo.hidden = true
            multipleTxt.hidden = true
            playBtn.hidden = true
            
            multipleEqn.hidden = false
            addBtn.hidden = false
            
            multiple = Int(multipleTxt.text!)!
        }
    }
    
    @IBAction func onAddBtnPressed(sender: UIButton) {
        
        if count < 5 {
            sum = prevSum + multiple
            multipleEqn.text = "\(prevSum) + \(multiple) = \(sum)"
            prevSum = sum
            count++
        } else {
            resetGame()
        }
    }
    
    func resetGame() {
        multipleTxt.text=""
        
        logo.hidden = false
        multipleTxt.hidden = false
        playBtn.hidden = false
        
        multipleEqn.hidden = true
        addBtn.hidden = true
        
        prevSum = 0
        multiple = 0
        sum = 0
        multipleEqn.text="Press Add to add!"
        count = 0
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
        
    }

}

