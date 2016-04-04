//
//  ViewController.swift
//  Retro-Calculator
//
//  Created by Ralph Cachero on 12/24/15.
//  Copyright © 2015 Teradek. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var outputLbl: UILabel!

    var player: AVAudioPlayer!
    
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var currentOperation: CalcService.Operation = CalcService.Operation.Empty
    var result = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AudioService.instance.soundFXPlayer = AudioService.instance.createPlayerWithUrl(AudioService.instance.btnUrl!)
        AudioService.instance.soundFXPlayer?.prepareToPlay()
    }

    @IBAction func numberPressed(btn: UIButton!){
        AudioService.instance.playCurrentSoundFX()
        
        runningNumber += "\(btn.tag)"
        outputLbl.text = runningNumber
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(CalcService.Operation.Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(CalcService.Operation.Multiply)
    }

    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(CalcService.Operation.Subtract)
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(CalcService.Operation.Add)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    @IBAction func onClearPressed(sender: AnyObject) {
        AudioService.instance.playCurrentSoundFX()
        outputLbl.text = "0"
        runningNumber = ""
        leftValStr = ""
        rightValStr = ""
        currentOperation = CalcService.Operation.Empty
        result = ""
    }
    
    func processOperation(op: CalcService.Operation) {
        AudioService.instance.playCurrentSoundFX()
        
        if currentOperation != CalcService.Operation.Empty {
            //Do some math
            
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == CalcService.Operation.Multiply {
                    result = CalcService.instance.multiply(leftValStr, numStrB: rightValStr)!
                } else if currentOperation == CalcService.Operation.Divide {
                    result = CalcService.instance.divide(leftValStr, numStrB: rightValStr)!
                } else if currentOperation == CalcService.Operation.Subtract {
                    result = CalcService.instance.subtract(leftValStr, numStrB: rightValStr)!
                } else if currentOperation == CalcService.Operation.Add {
                    result = CalcService.instance.add(leftValStr, numStrB: rightValStr)!
                }
                
                leftValStr = result
                outputLbl.text = result
            }
            
            currentOperation = op
            
        } else {
            //First time operator is pressed
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = op
            
        }
    }
    
}

