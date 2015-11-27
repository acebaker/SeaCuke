//
//  SeaScene.swift
//  SeaCuke
//
//  Created by Jeremy Juel on 11/25/15.
//  Copyright © 2015 Jeremy Juel. All rights reserved.
//

import SpriteKit

class SeaScene: SKScene {
    
    var bgNode = SKSpriteNode(imageNamed: "BG")
    
    override func didMoveToView(view: SKView) {
        backgroundColor = UIColor.redColor()
        
        updateBGImage(imageNamed: "BG")
        
        physicsWorld.gravity = CGVectorMake(0.0, 1.5)
        
        let spawnRandomBubble = SKAction.runBlock(spawnBubble)
        let waitTime = SKAction.waitForDuration(NSTimeInterval(randomNumber(min: 0.3, max: 1.0)))
        let sequence = SKAction.sequence([spawnRandomBubble, waitTime])
        runAction(SKAction.repeatActionForever(sequence))
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
    
    override func update(currentTime: NSTimeInterval) {
        
    }
    
    func updateBGImage(imageNamed imageNamed: String) {
        let newBGNode = SKSpriteNode(imageNamed: imageNamed)
        newBGNode.position = CGPoint(x: frame.size.width/2, y: frame.size.height/2)
        newBGNode.zPosition = 0.0
        bgNode = newBGNode
        //bgNode.size = CGSize(width: frame.size.width, height: frame.size.height)
        if (bgNode.parent == nil) {
            addChild(bgNode)
        }
        
    }
    
    
    func randomNumber(min min: CGFloat, max: CGFloat) -> CGFloat {
        let random = CGFloat(Float(arc4random()) / 0xFFFFFFFF)
        return random * (max - min) + min
    }
    
    func spawnBubble() {
        //let bubble = SKSpriteNode(color: UIColor(white: 1, alpha: 1), size: CGSize(width: 50, height: 50))
        let bubble = SKSpriteNode(imageNamed: "Bubble_01")
        bubble.position = CGPoint(x: frame.size.width * randomNumber(min: 0, max: 1), y: 0)
        bubble.alpha = 0.4
        bubble.zPosition = 99
        
        let scale = randomNumber(min: 0.1, max: 0.5)
        bubble.size = CGSize(width: bubble.size.width * scale, height: bubble.size.height * scale)
        
        bubble.physicsBody = SKPhysicsBody(circleOfRadius: bubble.frame.size.width)
        
        
        addChild(bubble)
    }
    
}
