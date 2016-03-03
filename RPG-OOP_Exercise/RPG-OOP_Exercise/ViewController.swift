//
//  ViewController.swift
//  RPG-OOP_Exercise
//
//  Created by Ralph Cachero on 1/3/16.
//  Copyright © 2016 Teradek. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var printLbl: UILabel!
    @IBOutlet weak var player1HpLbl: UILabel!
    @IBOutlet weak var player2HpLbl: UILabel!
    
    @IBOutlet weak var restartButton: UIButton!
    @IBOutlet weak var player1AttackBtn: UIButton!
    @IBOutlet weak var player2AttackBtn: UIButton!
    
    
    var player1: Orc!
    var player2: Spartan!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initializeGame()
    }
    
    @IBAction func player1AttackPressed(sender: AnyObject) {
        if player1.attemptAttack(player1.attackPwr) {
            printLbl.text = "Orc was attacked for \(player1.hp) HP "
            player1HpLbl.text = "\(player1.hp) HP"
        } else {
            printLbl.text = "Attack was unsuccessful"
        }
        
        if !player1.isAlive {
            player1HpLbl.text = ""
            player2HpLbl.text = "WIN!"
            printLbl.text = "Spartan has won!"
            gameOver()
        }
        
        player2AttackBtn.enabled = false
        NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "enablePlayer2Button", userInfo: nil, repeats: false)
    }
    
    @IBAction func player2AttackPressed(sender: AnyObject) {
        if player2.attemptAttack(player2.attackPwr) {
            printLbl.text = "Spartan was attacked for \(player2.hp) HP "
            player2HpLbl.text = "\(player2.hp) HP"
        } else {
            printLbl.text = "Attack was unsuccessful"
        }
        
        if !player2.isAlive {
            player2HpLbl.text = ""
            player1HpLbl.text = "WIN!"
            printLbl.text = "Orc has won!"
            gameOver()
        }
        
        player1AttackBtn.enabled = false
        NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "enablePlayer1Button", userInfo: nil, repeats: false)
 
    }
    
    @IBAction func onRestartPressed(sender: AnyObject) {
        initializeGame()
    }
    
    func initializeGame() {
        player1 = Orc(name: "OneHitWonder", hp: 110, attackPwr: 20)
        
        player2 = Spartan(name: "BigStick", hp: 110, attackPwr: 20)
        
        player1HpLbl.text = "\(player1.hp) HP"
        player2HpLbl.text = "\(player2.hp) HP"
        printLbl.text = "Press Attack to attack!"
        restartButton.hidden = true
        player1AttackBtn.hidden = false
        player2AttackBtn.hidden = false
    }

    func gameOver() {
        player1AttackBtn.hidden = true
        player2AttackBtn.hidden = true
        restartButton.hidden = false
    }
    
    func enablePlayer1Button() {
        player1AttackBtn.enabled = true
    }
    
    func enablePlayer2Button() {
        player2AttackBtn.enabled = true
    }
    
}

