//
//  ScoreLabel.swift
//  Juicy Breakout
//
//  Created by Hoang Doan on 10/2/16.
//  Copyright © 2016 Hoang Doan. All rights reserved.
//

import SpriteKit

class ScoreLabel: SKLabelNode {
    
    var score: Int!
    
    let scoreLabel = SKLabelNode(text: "Score: ")
    
    func settingLabel() -> SKLabelNode{
        scoreLabel.fontSize = 16
        scoreLabel.fontName = "Tahoma"
        scoreLabel.fontColor = UIColor(red:0.83, green:0.40, blue:0.21, alpha:1.0)
        scoreLabel.position = CGPoint(x: self.frame.width / 2, y: self.frame.height - 30)
        scoreLabel.text = "Score: \(score)"
        return scoreLabel
    }

}

