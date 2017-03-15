//
//  GameMenu.swift
//  Juicy Breakout
//
//  Created by SonVu on 10/2/16.
//  Copyright © 2016 Hoang Doan. All rights reserved.
//

import SpriteKit

class GameMenuScene: SKScene {
    override func didMove(to view: SKView) {
        addBackGround()
        addButton()
    }
    
    func addBackGround() {
        let backGround = SKSpriteNode(color: UIColor(red:0.97, green:0.95, blue:0.70, alpha:1.0), size: self.frame.size)
        backGround.anchorPoint = CGPoint.zero
        addChild(backGround)
    }
    
    func addButton() {
        
        let named = SKLabelNode(text: "Juicy Breaker")
        named.position.x = self.frame.size.width / 2
        named.position.y = self.frame.size.height / 2 + 50
        named.fontSize = 30
        named.fontColor = UIColor(red:0.38, green:0.74, blue:0.52, alpha:1.0)
        named.fontName = "Zapfino"
        addChild(named)
        
        
        let backgroundText = SKSpriteNode(color: UIColor(red:0.81, green:0.22, blue:0.27, alpha:1.0), size: CGSize(width: 500, height: 70))
        backgroundText.position.x = self.frame.size.width / 2
        backgroundText.position.y = self.frame.size.height / 2 - 150
//        backgroundText.anchorPoint = CGPoint.zero
        backgroundText.name = "Play"
        addChild(backgroundText)

        let cheat = SKLabelNode(text: "Tab to play")
        cheat.fontSize = 32
        cheat.fontColor = UIColor.white
        cheat.position.x = self.frame.size.width / 2
        cheat.position.y = self.frame.size.height / 2 - 160
        cheat.name = "Play"
        addChild(cheat)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            let touchNodes = self.nodes(at: location)
            for node in touchNodes {
                if(node.name == "Play") {
                    //1 creat secent
                    
                    let gameScene = GameScene(size: (self.view?.frame.size)!)
                    //2 transport
                    self.view?.presentScene(gameScene, transition: SKTransition.fade(with: UIColor.black, duration: 0.5))
                    GameScene.score = 0
                }
            }
        }
        
    }
}
