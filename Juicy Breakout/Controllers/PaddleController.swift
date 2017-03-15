//
//  PaddleController.swift
//  Juicy Breakout
//
//  Created by Hoang Doan on 10/1/16.
//  Copyright © 2016 Hoang Doan. All rights reserved.
//

import SpriteKit

class PaddleController: Controller {
    override func setup(_ parent: SKNode) {
        configPhysics()
        setupContact(parent: parent)
    }
    
    func setupContact(parent: SKNode) {
        self.view.handleContact = {
            otherView in
                if let gift = otherView as? GiftView {
                    gift.removeFromParent()
                    parent.run(SKAction.playSoundFileNamed("extend.wav", waitForCompletion: false))
                    
                    if gift.level == 1 {
                        //self.view.setScale(1.5)
                        let size = self.view.size.width
                        if size * 1.5 <= 150 {
                            self.view.run(SKAction.scale(by: 1.5, duration: 0.5))
                        }
                    }
                
                    if gift.level == 2 {
                        for nodeObject in parent.children {
                            let node = nodeObject as SKNode
                            if node.name == "ball" {
                                let ballView = View(color: UIColor(red:0.83, green:0.40, blue:0.21, alpha:1.0), size: CGSize(width: 10, height: 10))
                            
                                    ballView.position.x = node.position.x - 10
                                    ballView.position.y = node.position.y + 10
                                    ballView.name = "ball"
                                    parent.addChild(ballView)
                            
                                    let ballController = BallController(view: ballView)
                                    ballController.setup(parent)
                                    GameScene.ballControllers.append(ballController)
                                }
                            }
                  
                        }
            
                }
        }
    }

    
    func configPhysics() {
        view.physicsBody = SKPhysicsBody(rectangleOf: view.frame.size)
        view.physicsBody?.friction = 0.4
        view.physicsBody?.isDynamic = false
        view.physicsBody?.restitution = 0.1
        view.physicsBody?.categoryBitMask = paddleCategory
        view.physicsBody?.contactTestBitMask = giftCategory
    }
    
    
}
