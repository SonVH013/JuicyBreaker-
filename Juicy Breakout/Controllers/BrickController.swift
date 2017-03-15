//
//  BrickController.swift
//  Juicy Breakout
//
//  Created by Hoang Doan on 10/1/16.
//  Copyright © 2016 Hoang Doan. All rights reserved.
//

import SpriteKit

class BrickController: Controller {
    
    var level:Int = 0
        
    override func setup(_ parent: SKNode) {
        configPhysics()
    }
    
    
    func setLevel(number: Int)  {
        self.level = number
    }
    
    func changeView() {
        switch level {
            case 1:
                view = BrickView(color: UIColor(red:0.38, green:0.74, blue:0.52, alpha:1.0), size: CGSize(width: 40, height: 15))
                view.setLevel(number: 1)
                view.setHP(number: 1)
            case 2:
                view = BrickView(color: UIColor(red:0.74, green:0.52, blue:0.38, alpha:1.0), size: CGSize(width: 40, height: 15))
                view.setLevel(number: 2)
                view.setHP(number: 1)
            case 3:
                view = BrickView(color: UIColor(red:0.81, green:0.22, blue:0.27, alpha:1.0), size: CGSize(width: 40, height: 15))
                view.setLevel(number: 3)
                view.setHP(number: 1)
            case 4:
                view = BrickView(color: UIColor(red:0.74, green:0.38, blue:0.61, alpha:1.0), size: CGSize(width: 40, height: 15))
                view.setLevel(number: 4)
                view.setHP(number: 1)
            case 5:
                view = BrickView(color: UIColor(red:0.00, green:0.34, blue:0.61, alpha:1.0), size: CGSize(width: 40, height: 15))
                view.setLevel(number: 5)
                view.setHP(number: 2)
            default:
                view = BrickView(color: UIColor(red:0.01, green:0.66, blue:0.96, alpha:1.0), size: CGSize(width: 40, height: 15))
        }
    }
    
    func configPhysics() {
        view.name = "brick"
        view.physicsBody = SKPhysicsBody(rectangleOf: view.frame.size)
        view.physicsBody?.allowsRotation = false
        view.physicsBody?.friction = 0
        view.physicsBody?.categoryBitMask = brickCategory
        view.physicsBody?.collisionBitMask = 0
    }
}
