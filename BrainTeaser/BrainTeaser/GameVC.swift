//
//  GameVC.swift
//  BrainTeaser
//
//  Created by Ralph Cachero on 3/14/16.
//  Copyright © 2016 Teradek. All rights reserved.
//

import UIKit
import pop

class GameVC: UIViewController {

    @IBOutlet weak var yesBtn: CustomButton!
    @IBOutlet weak var noBtn: CustomButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var timerLbl: UILabel!
    
    var currentCard: Card!
    var previousCard: String?
    var timer = NSTimer()
    var counter: NSTimeInterval!
    
    var correctAnswer: Int = 0
    var incorrectAnswer: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        currentCard = createCardFromNib()
        currentCard.center = AnimationEngine.screenCenterPosition
        self.view.addSubview(currentCard)
    }

    // MARK: Button Actions
    
    @IBAction func yesPressed(sender: UIButton) {
        if (sender.titleLabel?.text == "YES") {
            checkAnswer(sender)
        } else {
            titleLbl.text = "Does this card match the previous card?"
        }
        previousCard = currentCard.currentShape
        showNextCard()
        
        print("Correct: \(correctAnswer)")
        print("Incorrect: \(incorrectAnswer)")
        
    }
    
    @IBAction func noPressed(sender: UIButton) {
        previousCard = currentCard.currentShape
        showNextCard()
        checkAnswer(sender)
        
        print("Correct: \(correctAnswer)")
        print("Incorrect: \(incorrectAnswer)")

    }
    
    // MARK: Show Game Cards
    
    func showNextCard() {
        
        if let current = currentCard {
            let cardToRemove = current
            currentCard = nil
            
            AnimationEngine.animateToPosition(cardToRemove, position: AnimationEngine.offScreenLeftPosition, completion: { (anim: POPAnimation!, finished: Bool) -> Void in
                cardToRemove.removeFromSuperview()
            })
        }
        
        if let next = createCardFromNib() {
            next.center = AnimationEngine.offScreenRightPosition
            self.view.addSubview(next)
            currentCard = next
            
            if noBtn.hidden {
                noBtn.hidden = false
                yesBtn.setTitle("YES", forState: .Normal)
                setTimer()
            }
            
            AnimationEngine.animateToPosition(next, position: AnimationEngine.screenCenterPosition, completion: { (anim: POPAnimation!, finished: Bool) -> Void in
                
            })
            
        }
    }
    
    func createCardFromNib() -> Card? {
        return NSBundle.mainBundle().loadNibNamed("Card", owner: self, options: nil)[0] as? Card
    }
    
    // MARK: Validate Answer
    
    func checkAnswer(sender: UIButton) {
        
        // Button Tag 1 = Yes, Button Tag 2 = No
        
        switch sender.tag {
        case 1:
            if (previousCard == currentCard.currentShape) {
                correctAnswer += 1
            } else {
                incorrectAnswer += 1
            }
            break;
        case 2:
            if (previousCard != currentCard.currentShape) {
                correctAnswer += 1
            } else {
                incorrectAnswer += 1
            }
        default: ()
            break;
        }
    }
    
    func displayAnswerFeedback() {
        
    }
    
    func gameOver() {
        
    }
    
    // MARK: Timer
    
    func setTimer() {
        counter = NSTimeInterval(60)
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("onTimer"), userInfo: nil, repeats: true)
    }
    
    func timerString(time: NSTimeInterval) -> String {
        let minutes = (Int(time) / 60) % 60
        let seconds = Int(time) % 60
        return String(format:"%d:%02d", minutes, seconds)
    }
    
    func onTimer() {
        if (counter > 0) {
            counter = counter - 1
            timerLbl.text = timerString(counter)
        } else {
            counter = 0
            timer.invalidate()
        }
    }
    
}
