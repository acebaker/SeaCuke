//
//  LuckyNoteViewController.swift
//  SeaCuke
//
//  Created by Jeremy Juel on 11/11/15.
//  Copyright © 2015 Jeremy Juel. All rights reserved.
//

import UIKit

class LuckyNoteViewController: UIViewController {

    @IBOutlet weak var noteTextLabel: UILabel!
    var noteMessages = [
        "You just got so much luck",
        "Luck is on its way",
        "You're in luck",
        "You lucky duck",
        "You got super lucky",
        "There's luck everywhere",
        "I sense luck in your future"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getLuckyNoteText() {
        let diceRoll = Int(arc4random_uniform(UInt32(noteMessages.count)))
        noteTextLabel?.text = noteMessages[diceRoll]
    }
    
    func createLuckyNote(parentVC: UIViewController) -> UIView {
        let luckyNote = self.view
        getLuckyNoteText()
        luckyNote.frame = CGRectMake(20, 120, parentVC.view.frame.width-40, 80)
        luckyNote.layer.cornerRadius = 10
        
        parentVC.view.addSubview(luckyNote)
        parentVC.view.bringSubviewToFront(luckyNote)
        luckyNote.alpha = 0
        luckyNote.transform = CGAffineTransformMakeTranslation(0, parentVC.view.frame.height/2)
        
        
        UIView.animateWithDuration(1.1, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0, options: [], animations: {
            luckyNote.alpha = 0.95
            luckyNote.transform = CGAffineTransformIdentity
            }, completion: { finished in
                self.removeLuckyNote(luckyNote)
        })
        
        return luckyNote
    }
    
    func removeLuckyNote(noteToRemove: UIView) {
        UIView.animateWithDuration(1.1, delay: 3.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0, options: [], animations: {
            //noteToRemove.transform = CGAffineTransformMakeTranslation(0, -self.parentViewController!.view.frame.height/2)
            noteToRemove.alpha = 0
            }, completion: { finished in
                noteToRemove.removeFromSuperview()
        })
    }
    
    
    
    

}
