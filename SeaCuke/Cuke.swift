//
//  Cuke.swift
//  SeaCuke
//
//  Created by Jeremy Juel on 11/17/15.
//  Copyright © 2015 Jeremy Juel. All rights reserved.
//

import Foundation
import UIKit
import AudioToolbox     // for vibration

// A protocol that the Cuke uses to inform its delegate of state change
protocol CukeDelegate {
    func getLucky(cuke: Cuke)
}

class Cuke: NSObject {
    
    var delegate: CukeDelegate?
    
    let excitementMax = 100
    var excitementCurrent = 0
    let cukeShapeLayer = CAShapeLayer()
    var cukeView: UIView?
    
    
    override init() {
        super.init()
    }
    
    // MARK: - Excitement Methods
    
    func getExcited() -> Int {
        let newExcitement = Int(arc4random_uniform(10) + 1)
        excitementCurrent += newExcitement
        if excitementCurrent >= excitementMax {
            fullyExcited()
        }
        return excitementCurrent
    }
    
    func fullyExcited() {
        delegate!.getLucky(self)
        resetExcitement()
    }
    
    func resetExcitement() -> Int {
        excitementCurrent = 0
        print("excitementCurrent Reset = \(excitementCurrent)")
        return excitementCurrent
    }
    
    
    // MARK: - Display methods
    
    func createCuke(parentView: UIView) -> CAShapeLayer {
        let path = UIBezierPath()
        cukeView = parentView
        path.moveToPoint(CGPoint(x: cukeView!.frame.width/2, y: cukeView!.frame.height-50))
        path.addLineToPoint(CGPoint(x: cukeView!.frame.width/2, y: 0))
        
        cukeShapeLayer.path = path.CGPath
        
        cukeShapeLayer.strokeColor = UIColor(red: 166/255, green: 255/255, blue: 232/255, alpha: 1.0).CGColor
        cukeShapeLayer.lineWidth = 100
        cukeShapeLayer.lineCap = "round"
        cukeShapeLayer.fillColor = nil
        cukeView!.layer.addSublayer(cukeShapeLayer)
        
        return cukeShapeLayer
    }
    
    func scaleCuke() {
        
        let toPath = UIBezierPath()
        toPath.moveToPoint(CGPoint(x: cukeView!.frame.width/2, y: cukeView!.frame.height-50))
        toPath.addLineToPoint(CGPoint(x: cukeView!.frame.width/2, y: CGFloat(self.excitementCurrent)*2))
        
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
    
    
}