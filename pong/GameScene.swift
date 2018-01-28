//
//  GameScene.swift
//  pong
//
//  Created by Brandon Klotz on 1/24/18.
//  Copyright © 2018 Brandon Klotz. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var ball = SKSpriteNode()
    var enemy = SKSpriteNode()
    var main = SKSpriteNode()
    
    var score = [Int]()
    
    var enemyScore = SKLabelNode()
    var mainScore = SKLabelNode()

    override func didMove(to view: SKView) {
        enemyScore = self.childNode(withName: "enemyScore") as! SKLabelNode
        mainScore = self.childNode(withName: "mainScore") as! SKLabelNode
    
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        enemy = self.childNode(withName: "enemy") as! SKSpriteNode
        
        enemy.position.y = (self.frame.height / 2) - 50
        
        main = self.childNode(withName: "main") as! SKSpriteNode
        main.position.y = (-self.frame.height / 2) + 50

        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        border.friction = 0
        border.restitution = 1
        
        self.physicsBody = border
        
        startGame()
    }
    
    func startGame() {
        score = [0,0]
        enemyScore.text = "\(score[1])"
        mainScore.text = "\(score[0])"
        ball.physicsBody?.applyImpulse(CGVector(dx: 10, dy: 10))
    }
    
    func addScore(playerThatScored : SKSpriteNode){
        ball.position = CGPoint(x: 0,y: 0)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        if playerThatScored == main {
            score[0] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: 10, dy: 10))
        }
        else if playerThatScored == enemy {
            score[1] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: -10, dy: -10))
        }
        enemyScore.text = "\(score[1])"
        mainScore.text = "\(score[0])"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if currentGameType == .twoPlayer {
                if location.y > 0 {
                    enemy.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
                if location.y < 0 {
                    main.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
            } else {
                main.run(SKAction.moveTo(x: location.x, duration: 0.2))
            }
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if currentGameType == .twoPlayer {
                if location.y > 0 {
                    enemy.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
                if location.y < 0 {
                    main.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
            } else {
                main.run(SKAction.moveTo(x: location.x, duration: 0.2))
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        switch currentGameType {
        case .easy:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.9))
            break
        case .medium:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.7))
            break
        case .hard:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.3))
            break
        case .twoPlayer:
            
            break
        }
        
        if ball.position.y <= main.position.y - 32 {
            addScore(playerThatScored: enemy)
        }
        else if ball.position.y >= enemy.position.y + 32 {
            addScore(playerThatScored: main)
        }
    }
}
