//
//  TestShapesViewController.swift
//  SeaCuke
//
//  Created by Jeremy Juel on 11/26/15.
//  Copyright © 2015 Jeremy Juel. All rights reserved.
//

import UIKit

class TestShapesViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawShape()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func drawShape() {
        let layer = CAShapeLayer()
        let path = UIBezierPath()
        path.moveToPoint(CGPoint(x: view.frame.width/2, y: view.frame.height-100))
        path.addLineToPoint(CGPoint(x: view.frame.width/2, y: view.frame.height-600))
        //path.addCurveToPoint(CGPoint(x: view.frame.width/2-100, y: view.frame.height-400), controlPoint1: CGPoint(x: view.frame.width/2, y: view.frame.height-400), controlPoint2: CGPoint(x: view.frame.width/2, y: view.frame.height-400))
        
        layer.path = path.CGPath
        
        layer.strokeColor = UIColor.redColor().CGColor
        layer.lineWidth = 100
        layer.lineCap = "round"
        layer.fillColor = nil
        view.layer.addSublayer(layer)
        
        
        let toPath = UIBezierPath()
        toPath.moveToPoint(CGPoint(x: view.frame.width/2, y: view.frame.height-100))
        toPath.addLineToPoint(CGPoint(x: view.frame.width/2, y: view.frame.height-300))
        
        let animation = CABasicAnimation(keyPath: "path")
        animation.duration = 2
        
        
        let spring = CASpringAnimation(keyPath: "path")
        //spring.damping =
        //spring.fromValue = layer.path
        spring.toValue = toPath.CGPath
        spring.duration = spring.settlingDuration
        
        animation.fillMode = kCAFillModeForwards
        animation.removedOnCompletion = false
        
        //layer.addAnimation(animation, forKey: nil)
        layer.addAnimation(spring, forKey: nil)
        
        
    }


}
