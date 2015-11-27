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
    let cukeShapeLayer = CAShapeLayer()
    
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
        
        createCuke()
        
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
        //cukeView.transform = transform
        
        makeBubble()
    }

    @IBAction func releaseTheButton(sender: AnyObject) {
        //cukeView.transform = CGAffineTransformIdentity
        cuke.getExcited()
        scaleCuke()
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
    
    func createCuke() -> CAShapeLayer {
        let path = UIBezierPath()
        path.moveToPoint(CGPoint(x: cukeView.frame.width/2, y: cukeView.frame.height-50))
        path.addLineToPoint(CGPoint(x: cukeView.frame.width/2, y: 0))
        
        cukeShapeLayer.path = path.CGPath
        
        cukeShapeLayer.strokeColor = UIColor(red: 166/255, green: 255/255, blue: 232/255, alpha: 1.0).CGColor
        cukeShapeLayer.lineWidth = 100
        cukeShapeLayer.lineCap = "round"
        cukeShapeLayer.fillColor = nil
        cukeView.layer.addSublayer(cukeShapeLayer)
        
        return cukeShapeLayer
    }
    
    func scaleCuke() {
        
        let toPath = UIBezierPath()
        toPath.moveToPoint(CGPoint(x: cukeView.frame.width/2, y: cukeView.frame.height-50))
        toPath.addLineToPoint(CGPoint(x: cukeView.frame.width/2, y: CGFloat(cuke.excitementCurrent)*2))
        
        let animation = CABasicAnimation(keyPath: "path")
        animation.duration = 0.1
        
        
        // Your new shape here
        animation.toValue = toPath.CGPath
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        // The next two line preserves the final shape of animation,
        // if you remove it the shape will return to the original shape after the animation finished
        animation.fillMode = kCAFillModeForwards
        animation.removedOnCompletion = false
        
        cukeShapeLayer.addAnimation(animation, forKey: nil)
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

