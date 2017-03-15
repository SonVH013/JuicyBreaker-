//
//  BallController.swift
//  Juicy Breakout
//
//  Created by Hoang Doan on 10/1/16.
//  Copyright © 2016 Hoang Doan. All rights reserved.
//

import SpriteKit

class BallController: Controller {
    
    var time = 0
    var count = 0
    
    var check = false
    
    
    override func setup(_ parent: SKNode) {
        configPhysics()
        setupContact(parent: parent)
   }
    

    func setupContact(parent: SKNode)  {
        
        self.view.handleContact = {
            otherView in
            if let paddle = otherView as? PaddleView {
                self.count = 0
                self.time = 0
                parent.run(SKAction.playSoundFileNamed("paddleBlip.wav", waitForCompletion: false))
            }
            
            if var brick = otherView as? BrickView {
               
                brick.hp -= 1
                print("Mau cua gach \(brick.hp)")
                
                if brick.hp == 0 {
                    brick.removeFromParent()
                }
               
                parent.run(SKAction.playSoundFileNamed("BambooBreak.wav", waitForCompletion: false))
                print(brick.level)
                if brick.level == 1 {
                    self.count += 1
                    self.time = 0
                    let particle = SKEmitterNode(fileNamed: "BrokenPlatform.sks")
                    particle?.position = brick.position
                    parent.addChild(particle!)
                }
                
                if brick.level == 2 {
                    self.time += 2
                    print(self.time)
                    self.count = 0
                    let particle = SKEmitterNode(fileNamed: "break_level_2.sks")
                    particle?.position = brick.position
                    parent.addChild(particle!)
                }
                
                if brick.level == 3 {
                    let particle = SKEmitterNode(fileNamed: "break_level_3.sks")
                    particle?.position = brick.position
                    parent.addChild(particle!)
                    self.addGift(parent: parent, giftType: 1)
                }
                
                if brick.level == 4 {
                    let particle = SKEmitterNode(fileNamed: "break_level_3.sks")
                    particle?.position = brick.position
                    parent.addChild(particle!)
                    self.addGift(parent: parent, giftType: 2)
                }
                
                if brick.level == 5 {
                    switch brick.hp {
                    case 1:
                        let colorize = SKAction.colorize(with: UIColor(red:0.51, green:0.83, blue:0.98, alpha:1.0), colorBlendFactor: 1, duration: 0.5)
                        brick.run(colorize)

                    case 0:
                        GameScene.score += 5
                        let particle = SKEmitterNode(fileNamed: "break_level_5.sks")
                        particle?.position = brick.position
                        parent.addChild(particle!)
                        let randomGift = Int(arc4random_uniform(5))
                        if randomGift > 0 && randomGift < 3 {
                            self.addGift(parent: parent, giftType: randomGift)
                        }
                        
                    default:
                        let colorize = SKAction.colorize(with: UIColor(red:0.51, green:0.83, blue:0.98, alpha:1.0), colorBlendFactor: 1, duration: 0.5)
                        brick.run(colorize)
                    }
                }
                
                //self.totalPoint += self.count
                GameScene.score += self.count + self.time
                
            }
            if let bottomBorder = otherView as? BottomView {
                self.view.removeFromParent()
                self.check = true
            }
        }
    }
    
    
    func configPhysics() {
        view.name = "ball"
        view.physicsBody = SKPhysicsBody(rectangleOf: view.frame.size)
        view.physicsBody?.friction = 0
        view.physicsBody?.allowsRotation = false
        view.physicsBody?.restitution = 1
        view.physicsBody?.linearDamping = 0
        view.physicsBody?.applyImpulse(CGVector(dx: 0.75 , dy: 0.75))
        view.physicsBody?.categoryBitMask = ballCategory
        view.physicsBody?.contactTestBitMask = (bottomCategory | brickCategory | paddleCategory)
        view.physicsBody?.collisionBitMask = (bottomCategory | brickCategory | paddleCategory)
    }
    
    func addGift(parent: SKNode, giftType: Int) {
        var gift = GiftView()
        switch giftType {
        case 1:
            gift = GiftView(color: UIColor(red:0.81, green:0.22, blue:0.27, alpha:1.0), size: CGSize(width: 25, height: 5))
            gift.setLevel(number: 1)
        case 2:
            gift = GiftView(color: UIColor(red:0.74, green:0.38, blue:0.61, alpha:1.0), size: CGSize(width: 10, height: 10))
            gift.setLevel(number: 2)
        default:
            gift = GiftView(color: UIColor(red:0.81, green:0.22, blue:0.27, alpha:1.0), size: CGSize(width: 25, height: 5))
        }
        gift.position = view.position
        let giftController = GiftController(view: gift)
        giftController.setup(parent)
        parent.addChild(gift)
        
    }
}
