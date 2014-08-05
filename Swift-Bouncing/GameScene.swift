//
//  GameScene.swift
//  Swift-Bouncing
//
//  Created by Seung Kyun Nam on 2014. 6. 5..
//  Copyright (c) 2014년 litmuscube. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        self.addChild(self.createFloor())
        physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
    }
    
    func createFloor() -> SKSpriteNode {
        let floor = SKSpriteNode(color: SKColor.brownColor(), size: CGSizeMake(self.frame.size.width, 20))

        floor.anchorPoint = CGPointMake(0, 0)
        floor.name = "floor"
        floor.physicsBody = SKPhysicsBody(edgeLoopFromRect: floor.frame)
        floor.physicsBody.dynamic = false
        
        return floor
    }
    
    func createBall(position: CGPoint) -> SKShapeNode {
        let ball = SKShapeNode(circleOfRadius: 20.0)
        let positionMark = SKShapeNode(circleOfRadius: 6.0)
        
        ball.position = position
        ball.name = "ball"
        
        ball.physicsBody = SKPhysicsBody(circleOfRadius: 20.0)
        ball.physicsBody.dynamic = true
        ball.physicsBody.restitution = 0.7
        
        positionMark.position.y = -12
        ball.addChild(positionMark)
        
        return ball
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            let floor = self.childNodeWithName("floor")
            if !floor.containsPoint(location) {
                self.addChild(self.createBall(location))
            }
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    override func didSimulatePhysics() {
        self.enumerateChildNodesWithName("ball", usingBlock: { (node: SKNode!, stop: UnsafeMutablePointer<ObjCBool>) -> Void in
            if node.position.y < 0 {
                node.removeFromParent()
            }
        })
    }
}
