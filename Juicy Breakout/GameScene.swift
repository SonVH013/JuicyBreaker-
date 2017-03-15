//
//  GameScene.swift
//  Juicy Breakout
//
//  Created by Hoang Doan on 9/29/16.
//  Copyright © 2016 Hoang Doan. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate{
    
    static var score:Int = 0
    
    var scoreLabel : SKLabelNode!
    var bottom:SKSpriteNode!

    var paddleController:PaddleController!
    var ballController:BallController!
    var brick: [Controller?] = []
    static var ballControllers: [BallController] = []
    
   
    override func didMove(to view: SKView) {
        configBorder()
        addBackGround()
        addGameSound()
        addPaddle()
        addBall()
        addBottom()
        addBricks()
        addScore()
        addCheat()
        configCollision()
    }
    
    //GAME SOUND
    func addGameSound() {
        //backgroundMusic = SKAudioNode(fileNamed: "gamesound.mp3")
        //addChild(backgroundMusic)
        //self.run(SKAction.playSoundFileNamed("gamesound.mp3", waitForCompletion: false))
        
        let backgroundMusic = SKAudioNode(fileNamed: "gamesound.mp3")
        backgroundMusic.autoplayLooped = true
        addChild(backgroundMusic)
    }
   
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        scoreLabel.text = "Score: \(GameScene.score)"
        if gameOver() {
            changeToGameOver()
        }
        
        
        if(gameWin() == true) {
            changeToWin()
        }
    }
    
    //ADD CHEAT
    func addCheat() {
        let cheat = SKLabelNode(text: "next")
        cheat.fontSize = 13
        cheat.fontColor = UIColor.blue
        cheat.position.x = self.frame.size.width - 30
        cheat.position.y = self.frame.size.height - 30
        cheat.name = "next"
        addChild(cheat)
        
        let back = SKLabelNode(text: "back")
        back.fontSize = 13
        back.fontColor = UIColor.blue
        back.position.x = 30
        back.position.y = self.frame.size.height - 30
        back.name = "back"
        addChild(back)
    }
    
    
    
    //ADD SCORR LABEL
    func addScore()  {
        scoreLabel = SKLabelNode(text: "Score: ")
        scoreLabel.fontSize = 16
        scoreLabel.fontName = "Tahoma"
        scoreLabel.fontColor = UIColor(red:0.83, green:0.40, blue:0.21, alpha:1.0)
        scoreLabel.position = CGPoint(x: self.frame.width / 2, y: self.frame.height - 30)
        scoreLabel.text = "0"
        addChild(scoreLabel)
    }
    
    //ADD BACKGROUND
    func addBackGround() {
        let backGround = SKSpriteNode(color: UIColor(red:0.97, green:0.95, blue:0.70, alpha:1.0), size: self.frame.size)
        backGround.anchorPoint = CGPoint.zero
        addChild(backGround)
    }
    
    //CONFIG BORDER
    func configBorder() {
        let worldBorder = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsBody = worldBorder
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
    }
    
    //ADD BALL
    func addBall() {
        
        let ballView = View(color: UIColor(red:0.83, green:0.40, blue:0.21, alpha:1.0), size: CGSize(width: 10, height: 10))
        
        ballView.position = CGPoint(x: self.frame.width/2, y: self.frame.height/4)
        ballView.name = "ball"
        self.addChild(ballView)
        
        self.ballController = BallController(view: ballView)
        self.ballController.setup(self)
        
        GameScene.ballControllers.append(self.ballController)

    }
    
    //ADD PADDLE
    func addPaddle()  {
        
        let paddleView = PaddleView(color: UIColor(red:0.81, green:0.22, blue:0.27, alpha:1.0), size: CGSize(width: 100, height: 10))

        paddleView.position = CGPoint(x: self.frame.width/2, y: paddleView.frame.height * 5)
        paddleView.name = "paddeCategoryName"
        self.addChild(paddleView)
        
        self.paddleController = PaddleController(view: paddleView)
        self.paddleController.setup(self)
    }
    
    //ADD BOTTOM
    func addBottom() {
        let bottomRect = CGRect(origin: self.frame.origin, size: CGSize(width: self.frame.width, height: 1))
        bottom = SKSpriteNode()
        bottom = BottomView()
        bottom.name = "bottomBorder"
        bottom.physicsBody = SKPhysicsBody(edgeLoopFrom: bottomRect)
        self.addChild(bottom)
    }
    
    //ADD BRICK
    func addBricks() {
        let numberOfRows = 6
        let numberOfBricks = 6
        let brickWidth = 40
        let padding = 5
        let offset = Float(self.frame.size.width) - Float(brickWidth * numberOfBricks + padding * (numberOfBricks) - 1 )
    
        let finalOffset = offset / 2
        
        for index in 1 ... numberOfRows {
            
            
            var yOffset:CGFloat {
                switch index {
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
                singleBrickController.setLevel(number: 1)
                singleBrickController.changeView()
                singleBrickController.view.position = CGPoint(x: position, y: yOffset)
                singleBrickController.view.name = "brick"
                singleBrickController.view.setHP(number: 1)
                self.addChild(singleBrickController.view)
                singleBrickController.setup(self)
                self.brick.append(singleBrickController)
                
            }
        }
        
    }
    
    
    func configCollision() {
        self.physicsWorld.contactDelegate = self
        bottom.physicsBody?.categoryBitMask = bottomCategory
    }
    
   
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            let touchNode = self.nodes(at: location)
            for node in touchNode {
                if(node.name == "next") {
                    //1 creat secent
                    let gameScene = SceneLevel2(size: (self.view?.frame.size)!)
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
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let touchLocation = touch?.location(in: self)
        let prevLocation = touch?.previousLocation(in: self)        
        
        var newPos = self.paddleController.view.position.x + ((touchLocation?.x)! - (prevLocation?.x)!)
        
        newPos = max(newPos, self.paddleController.view.size.width/2)
        newPos = min(newPos, self.frame.width - self.paddleController.view.frame.width/2)
        self.paddleController.view.position = CGPoint(x: newPos, y: self.paddleController.view.position.y)
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody = SKPhysicsBody()
        var secondBody = SKPhysicsBody()

        if  contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        
            if  firstBody.node?.name != nil && secondBody.node?.name != nil {
                let nodeA = firstBody.node as! View
                let nodeB = secondBody.node as! View
                if let aHandleContact = nodeA.handleContact {
                    aHandleContact(nodeB)
                }
                
                if let bHandleContact = nodeB.handleContact {
                    bHandleContact(nodeA)
                }

            }
            
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
            if  firstBody.node?.name != nil && secondBody.node?.name != nil {
                
                let nodeA = firstBody.node as! View
                let nodeB = secondBody.node as! View
                
                if let aHandleContact = nodeA.handleContact {
                    aHandleContact(nodeB)
                }
                
                if let bHandleContact = nodeB.handleContact {
                    bHandleContact(nodeA)
                }
            }
        }
        
    }
    
   
    func changeToGameOver() {
            let gameScene = GameOverScence(size: (self.view?.frame.size)!)
            self.view?.presentScene(gameScene, transition: SKTransition.fade(with: UIColor(red:0.97, green:0.95, blue:0.70, alpha:1.0), duration: 0.1))
            
            self.run(SKAction.playSoundFileNamed("game-over.wav", waitForCompletion: false))
    }
    
    func changeToWin() {
        let gameScene = SceneLevel2(size: (self.view?.frame.size)!)
        self.view?.presentScene(gameScene, transition: SKTransition.doorsCloseHorizontal(withDuration: 0.5))
//        self.run(SKAction.playSoundFileNamed("game-won.mp3", waitForCompletion: false))

    }
    
    func gameOver() -> Bool {
        var numberOfBalls = 0
        for nodeObject in self.children {
            let node = nodeObject as SKNode
            if node.name == "ball" {
                numberOfBalls += 1
            }
        }
        return numberOfBalls <= 0
    }
    
    
    func gameWin() -> Bool {
        var numberOfBricks = 0
        for nodeObject in self.children {
            let node = nodeObject as SKNode
            if node.name == "brick" {
                numberOfBricks += 1
            }
        }
        return numberOfBricks <= 0
    }
}
