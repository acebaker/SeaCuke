//
//  ViewController.swift
//  SeaCuke
//
//  Created by Jeremy Juel on 11/11/15.
//  Copyright © 2015 Jeremy Juel. All rights reserved.
//

import UIKit
import SpriteKit
import AudioToolbox     // for vibration

class ViewController: UIViewController, CukeDelegate {

    @IBOutlet weak var rubButton: UIButton!
    @IBOutlet weak var cukeView: UIView!
    
    var luckyNoteVC = LuckyNoteViewController!()
    let cuke = Cuke()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let scene = SeaScene(fileNamed:"SeaScene") {
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            
            skView.presentScene(scene)
        }
        
        
        //cukeView.layer.anchorPoint = CGPointMake(0.5, 0.9)
        //cukeView.transform = CGAffineTransformMakeTranslation(0, cukeView.frame.height*0.8)
        
        cuke.delegate = self
        
        luckyNoteVC = storyboard?.instantiateViewControllerWithIdentifier("LuckyNoteViewController") as! LuckyNoteViewController
        self.addChildViewController(luckyNoteVC)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pressTheButton(sender: AnyObject) {
        let transform = CGAffineTransformMakeScale(0.96, 0.9)
        cukeView.transform = transform
        
        makeBubble()
    }

    @IBAction func releaseTheButton(sender: AnyObject) {
        cukeView.transform = CGAffineTransformIdentity
        cuke.getExcited()
    }
    
    override func motionBegan(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if motion == .MotionShake {
            print("Shake began")
            cuke.getExcited()
        }
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if motion == .MotionShake {
            print("Shake ended")
            cuke.getExcited()
        }
    }
    
    func getLucky(cuke: Cuke) {
        print("getLucky Fired")
        AudioServicesPlaySystemSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate), { finished in
            print("finished vibrating!")
        })
        luckyNoteVC.createLuckyNote(self)
    }
    
    
    
    func makeBubble() {
        let bubbleX = CGFloat(arc4random_uniform(UInt32(cukeView.frame.width)) + UInt32(cukeView.frame.origin.x))
        let bubbleY = CGFloat(arc4random_uniform(UInt32(cukeView.frame.height)) + UInt32(cukeView.frame.origin.y))
        
        let radius = CGFloat(arc4random_uniform(15) + 2)
        
        let bubbleFrame = CGRectMake(bubbleX, bubbleY, radius*2, radius*2)
        let bubble = UIView(frame: bubbleFrame)
        bubble.backgroundColor = UIColor(white: 1, alpha: 0.5)
        
        bubble.layer.cornerRadius = radius
        
        self.view.addSubview(bubble)
        
        UIView.animateWithDuration(2, delay: 0, options: [.CurveEaseOut], animations: {
            bubble.transform = CGAffineTransformMakeTranslation(0, -self.view.frame.height)
            }, completion: { finised in
                bubble.removeFromSuperview()
        })
        
    }

}

