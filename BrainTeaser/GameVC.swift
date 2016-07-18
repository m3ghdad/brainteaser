//
//  GameVC.swift
//  BrainTeaser
//
//  Created by Meghdad Abbaszadegan on 7/16/16.
//  Copyright © 2016 Meghdad. All rights reserved.
//

import UIKit
import pop

class GameVC: UIViewController {
    
    @IBOutlet weak var yesBtn: CostumButton!
    @IBOutlet weak var noBtn: CostumButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var checkImg: UIImageView!
    
    var currentCard: Card!
    var previousCard: Card!
    var timer = NSTimer()
    var startDate: NSDate!
    
    let gameTime = 25.0
    var correctCards = 0
    var wrongCards = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentCard = createCardFromNib()
        currentCard.center = AnimationEngine.screenCenterPosition
        previousCard = currentCard
        self.view.addSubview(currentCard)
        
    }
    
    @IBAction func yesPressed(sender: UIButton) {
        if sender.titleLabel?.text == "YES" {
            checkAnswer(true)
        } else {
            startTimer()
            titleLbl.text = "Does this Card match the previous?"
        }
        
        showNextCard()
    }
    
    @IBAction func noPressed(sender: AnyObject) {
        checkAnswer(false)
        showNextCard()
    }
    
    func showNextCard() {
        checkImg.alpha = 1.0
        if let current = currentCard {
            let cardToRemove = current
            previousCard = current
            currentCard = nil
            
            AnimationEngine.animateToPosition(cardToRemove, position: AnimationEngine.offScreenLeftPosition, completion: { (anim: POPAnimation!, finished: Bool) in
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
            }
            
            AnimationEngine.animateToPosition(next, position: AnimationEngine.screenCenterPosition, completion: { (anim:POPAnimation!, finished:Bool) in
                
            })
        }
    }
    
    func createCardFromNib() -> Card? {
        return NSBundle.mainBundle().loadNibNamed("Card", owner: self, options: nil)[0] as? Card
    }
    
    func checkAnswer(guess: Bool) -> Bool {
        let isSame = currentCard.currentShape == previousCard.currentShape
        if guess == isSame {
            correctCards += 1
            indicateCorrectGuess()
        } else {
            wrongCards += 1
            indicateWrongGuess()
        }
        
        return guess == isSame
    }
    
    func startTimer() {
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(GameVC.updateTimer), userInfo: nil, repeats: true)
        startDate = NSDate()
    }
    
    func stopTimer() {
        timer.invalidate()
    }
    
    func updateTimer() {
        let currentDate = NSDate()
        let timeDifference = currentDate.timeIntervalSinceDate(startDate)
        
        let timeLeft = gameTime - timeDifference
        
        if timeLeft <= 0 {
            stopTimer()
            timeLbl.text = "0:25"
            yesBtn.setTitle("START", forState: .Normal)
            noBtn.hidden = true
            performSegueWithIdentifier("score", sender: self)
        }
        else {
            //update the time label. Truncate the Double by converting it to an Int
            let minutesLeft = Int(timeLeft / 60.0)
            let secondsLeft = Int(timeLeft) % 60
            timeLbl.text = "\(minutesLeft):\(secondsLeft)"
        }
    }
    
    func indicateCorrectGuess() {
        
        checkImg.image = UIImage(named: "checkmark")
        AnimationEngine.popAnimation(checkImg)
    }
    func indicateWrongGuess() {
        checkImg.image = UIImage(named: "wrong")
        AnimationEngine.popAnimation(checkImg)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let scoreVC = segue.destinationViewController as? ScoreVC {
            scoreVC.correctCards = correctCards
            scoreVC.wrongCards = wrongCards
        }
    }
}
