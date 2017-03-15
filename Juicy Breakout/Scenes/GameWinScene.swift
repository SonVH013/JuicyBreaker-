//
//  GameWinScene.swift
//  Juicy Breakout
//
//  Created by Hoang Doan on 10/2/16.
//  Copyright © 2016 Hoang Doan. All rights reserved.
//

import Foundation
import SpriteKit

class GameWinScene: SKScene {
    override func didMove(to view: SKView) {
        addBackGround()
        let label = SKLabelNode(text: "Congratulation! You Win")
        label.fontSize = 24
        label.fontName = "Tahoma"
        label.fontColor = UIColor(red:0.81, green:0.22, blue:0.27, alpha:1.0)
        label.position = CGPoint(x: self.frame.size.width/2, y:  self.frame.size.height/2 + 50)
        addChild(label)
        
        let againLabel = SKLabelNode(text: "Tap to replay!")
        againLabel.fontSize = 24
        againLabel.fontName = "Tahoma"
        againLabel.fontColor = UIColor(red:0.81, green:0.22, blue:0.27, alpha:1.0)
        againLabel.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        addChild(againLabel)
        
    }
    
    func addBackGround() {
        let backGround = SKSpriteNode(color: UIColor(red:0.97, green:0.95, blue:0.70, alpha:1.0), size: self.frame.size)
        backGround.anchorPoint = CGPoint.zero
        addChild(backGround)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let gameScene = GameScene(size: (self.view?.frame.size)!)
        GameScene.score = 0
        self.view?.presentScene(gameScene, transition: SKTransition.fade(with: UIColor(red:0.97, green:0.95, blue:0.70, alpha:1.0), duration: 0.1))
    }
}
