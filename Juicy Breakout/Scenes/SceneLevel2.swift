//
//  SceneLevel2.swift
//  Juicy Breakout
//
//  Created by Hoang Doan on 10/2/16.
//  Copyright © 2016 Hoang Doan. All rights reserved.
//

import SpriteKit

class SceneLevel2: GameScene {
    
    
        
    override func addBricks() {
        let numberOfRows = 6
        let numberOfBricks = 6
        let brickWidth = 40
        let padding = 5
        let offset = Float(self.frame.size.width) - Float(brickWidth * numberOfBricks + padding * (numberOfBricks) - 1 )
        
        let finalOffset = offset / 2
        
        for row in 1 ... numberOfRows {
            
            var yOffset:CGFloat {
                switch row {
                case 1:
                    return self.frame.size.height * 0.9
                case 2:
                    return self.frame.size.height * 0.85
                case 3:
                    return self.frame.size.height * 0.8
                case 4:
                    return self.frame.size.height * 0.75
                case 5:
                    return self.frame.size.height * 0.7
                case 6:
                    return self.frame.size.height * 0.65
                default:
                    return 0
                }
            }
            
            
            for index in 1 ... numberOfBricks {
                let brickView = BrickView(color: UIColor(red:0.38, green:0.74, blue:0.52, alpha:1.0), size: CGSize(width: 40, height: 15))
                
                
                let calc1:Float = Float(index) - 0.5
                let calc2:Float = Float(index) - 1
                let position = CGFloat(calc1  * Float(brickView.frame.size.width) + calc2 * Float(padding) + finalOffset)
                
                let singleBrickController = BrickController(view: brickView)
                if (row % 2 == 0 && index % 3 == 0) {
                    singleBrickController.setLevel(number: 4)

                }
                else if (row % 2 != 0 && index % 3 == 0) {
                    singleBrickController.setLevel(number: 3)
                    
                } else if row % 2 != 0 {
                    singleBrickController.setLevel(number: 1)


                } else if row % 2 == 0 {
                    singleBrickController.setLevel(number: 2)
                }
                
                singleBrickController.changeView()
                singleBrickController.view.position = CGPoint(x: position, y: yOffset)
                singleBrickController.view.name = "brick"
                self.addChild(singleBrickController.view)
                singleBrickController.setup(self)
                self.brick.append(singleBrickController)
                
            }
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            let touchNode = self.nodes(at: location)
            for node in touchNode {
                if(node.name == "next") {
                    //1 creat secent
                    let gameScene = SceneLevel3(size: (self.view?.frame.size)!)
                    //2 transport
                    self.view?.presentScene(gameScene, transition: SKTransition.doorsCloseHorizontal(withDuration: 0.5))
                }
                if(node.name == "back") {
                    //1 creat secent
                    let gameScene = GameMenuScene(size: (self.view?.frame.size)!)
                    //2 transport
                    self.view?.presentScene(gameScene, transition: SKTransition.flipHorizontal(withDuration: 0.5))
                }
                
            }
        }
    }
    
    override func changeToWin() {
        let gameScene = SceneLevel3(size: (self.view?.frame.size)!)
        self.view?.presentScene(gameScene, transition: SKTransition.doorsCloseHorizontal(withDuration: 0.5))
    }
}
