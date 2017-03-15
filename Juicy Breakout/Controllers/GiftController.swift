//
//  GiftController.swift
//  Juicy Breakout
//
//  Created by Hoang Doan on 10/2/16.
//  Copyright © 2016 Hoang Doan. All rights reserved.
//

import SpriteKit

class GiftController: Controller {
    override func setup(_ parent: SKNode) {
        configPhysics()
        setupContact(parent: parent)
    }
    
    func setupContact(parent: SKNode) {
        self.view.handleContact = {
            otherView in
            if let bottom = otherView as? BottomView {
                self.view.removeFromParent()
            }
        }
    }

    func configPhysics() {
        view.name = "gift"
        view.physicsBody = SKPhysicsBody(rectangleOf: view.frame.size)
        view.physicsBody?.allowsRotation = false
        view.physicsBody?.friction = 0
        view.physicsBody?.categoryBitMask = giftCategory
        view.physicsBody?.collisionBitMask = (paddleCategory | bottomCategory)
        view.physicsBody?.contactTestBitMask = bottomCategory
        
        self.view.run(
            SKAction.repeatForever(
                SKAction.sequence(
                    [
                        SKAction.run({
                            self.view.physicsBody?.velocity.dy = -50
                        }),
                        SKAction.wait(forDuration: 0.3)
                    ]
                )

            )
        )
    }
    
    
}
