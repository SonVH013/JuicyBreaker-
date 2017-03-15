//
//  View.swift
//  Juicy Breakout
//
//  Created by Hoang Doan on 10/1/16.
//  Copyright © 2016 Hoang Doan. All rights reserved.
//

import SpriteKit

typealias HandleContactType = ((_ otherView: View) -> Void)


class View : SKSpriteNode {
    var handleContact : HandleContactType?
    
    var level:Int = 0
    
    var hp:Int = 0
    
    func setLevel(number: Int) {
        self.level = number
    }
    
    func setHP(number: Int) {
        self.hp = number
    }
    
}
