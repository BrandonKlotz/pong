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
        
        startGame()
        
        enemyScore = self.childNode(withName: "enemyScore") as! SKLabelNode
        mainScore = self.childNode(withName: "mainScore") as! SKLabelNode
    
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        enemy = self.childNode(withName: "enemy") as! SKSpriteNode
        main = self.childNode(withName: "main") as! SKSpriteNode
        
        ball.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 20))

        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        border.friction = 0
        border.restitution = 1
        
        self.physicsBody = border
    }
    
    func startGame() {
        score = [0,0]
        enemyScore.text = "\(score[1])"
        mainScore.text = "\(score[0])"
    }
    
    func addScore(playerThatScored : SKSpriteNode){
        ball.position = CGPoint(x: 0,y: 0)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        if playerThatScored == main {
            score[0] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 20))
        }
        else if playerThatScored == enemy {
            score[1] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: -20, dy: -20))
        }
        enemyScore.text = "\(score[1])"
        mainScore.text = "\(score[0])"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            main.run(SKAction.moveTo(x: location.x, duration: 0.2))
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            main.run(SKAction.moveTo(x: location.x, duration: 0.2))
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.1))
        
        if ball.position.y <= main.position.y - 40 {
            addScore(playerThatScored: enemy)
        }
        else if ball.position.y >= enemy.position.y + 40 {
            addScore(playerThatScored: main)
        }
    }
}
