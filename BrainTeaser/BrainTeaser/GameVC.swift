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

    // MARK: Outlets
    
    @IBOutlet weak var yesBtn: CustomButton!
    @IBOutlet weak var noBtn: CustomButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var timerLbl: UILabel!
    
    //MARK: Variables
    
    var currentCard: Card!
    var previousCard: String?
    var timer = NSTimer()
    var counter: NSTimeInterval!
    var scoreCard: Score!
    
    var correctAnswer: Int = 0
    var incorrectAnswer: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        currentCard = createCardFromNib()
        currentCard.center = AnimationEngine.screenCenterPosition
        self.view.addSubview(currentCard)
        
        scoreCard = createScoreCard()
        
    }

    // MARK: Button Actions
    
    @IBAction func yesPressed(sender: UIButton) {
        if (sender.titleLabel?.text == "YES") {
            checkAnswer(sender)
            previousCard = currentCard.currentShape
            showNextCard()
        } else if (sender.titleLabel?.text == "RESTART") {
            titleLbl.text = "Remember this image"
            scoreCard.removeFromSuperview()
            correctAnswer = 0
            incorrectAnswer = 0
            yesBtn.setTitle("START", forState: .Normal)
            
            currentCard = createCardFromNib()
            currentCard.center = AnimationEngine.screenCenterPosition
            self.view.addSubview(currentCard)
            timerLbl.text = "1:00"
            
        } else {
            titleLbl.text = "Does this card match the previous card?"
            previousCard = currentCard.currentShape
            showNextCard()
        }
        
    }
    
    @IBAction func noPressed(sender: UIButton) {
        checkAnswer(sender)
        previousCard = currentCard.currentShape
        showNextCard()
        
    }
    
    // MARK: Show Game Cards
    
    func showNextCard() {
        
        if let current = currentCard {
            let cardToRemove = current
            currentCard = nil
            
            let time = dispatch_time(DISPATCH_TIME_NOW, Int64(Double(0.2) * Double(NSEC_PER_SEC)))
            
            dispatch_after(time, dispatch_get_main_queue()) {
            AnimationEngine.animateToPosition(cardToRemove, position: AnimationEngine.offScreenLeftPosition, completion: { (anim: POPAnimation!, finished: Bool) -> Void in
                cardToRemove.removeFromSuperview()
            })
            }
        }
        
        if let next = createCardFromNib() {
            
            let time = dispatch_time(DISPATCH_TIME_NOW, Int64(Double(0.3) * Double(NSEC_PER_SEC)))
            dispatch_after(time, dispatch_get_main_queue()) {
                next.center = AnimationEngine.offScreenRightPosition
                self.view.addSubview(next)
            }
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
                currentCard.answerImage.hidden = false
                currentCard.answerImage.image = UIImage(named: "correct")
            } else {
                incorrectAnswer += 1
                currentCard.answerImage.hidden = false
                currentCard.answerImage.image = UIImage(named: "incorrect")
            }
            break;
        case 2:
            if (previousCard != currentCard.currentShape) {
                correctAnswer += 1
                currentCard.answerImage.hidden = false
                currentCard.answerImage.image = UIImage(named: "correct")
            } else {
                incorrectAnswer += 1
                currentCard.answerImage.hidden = false
                currentCard.answerImage.image = UIImage(named: "incorrect")

            }
        default: ()
            break;
        }
    }
    
    // MARK: Game Over and Final Score Card
    
    func createScoreCard() -> Score? {
        return NSBundle.mainBundle().loadNibNamed("Score", owner: self, options: nil)[0] as? Score
    }
    
    func gameOver() {
        
        noBtn.hidden = true
        yesBtn.setTitle("RESTART", forState: .Normal)
        titleLbl.text = "Game Score"

        
        if let current = currentCard {
            let cardToRemove = current
            currentCard = nil            
            AnimationEngine.animateToPosition(cardToRemove, position: AnimationEngine.offScreenLeftPosition, completion: { (anim: POPAnimation!, finished: Bool) -> Void in
                cardToRemove.removeFromSuperview()
            })
        }
        
        scoreCard.center = AnimationEngine.offScreenRightPosition
        self.view.addSubview(scoreCard)
            
        scoreCard.correctScore.text = "\(correctAnswer)"
        scoreCard.incorrectScore.text = "\(incorrectAnswer)"
        scoreCard.totalScore.text = "\(correctAnswer + incorrectAnswer)"
            
        AnimationEngine.animateToPosition(scoreCard, position: AnimationEngine.screenCenterPosition, completion: { (anim: POPAnimation!, finished: Bool) -> Void in
                
        })

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
            gameOver()
            timer.invalidate()
        }
    }

    
}
