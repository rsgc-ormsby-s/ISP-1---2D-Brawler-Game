//
//  GameScene.swift
//  2D Brawler Game
//
//  Created by Student on 2017-03-02.
//  Copyright © 2017 Student. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var billy = SKSpriteNode()
    
    let scoreLabel = SKLabelNode(fontNamed: "Helvetica-Bold")
    var score = 3

    // Declare billy movements
    var moveUp = SKAction()
    var moveDown = SKAction()
    var moveRight = SKAction()
    var moveLeft = SKAction()
    // This method runs once after the scene loads
    override func didMove(to view: SKView) {
        //Set the background
        backgroundColor = SKColor.black
        let background = SKSpriteNode(imageNamed: "Grass")
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        background.size = self.frame.size
        background.zPosition = -1
        self.addChild(background)
        //Add the Sprite for Billy
        billy = SKSpriteNode(imageNamed: "Backwards")
        billy.position = CGPoint(x: size.width / 2, y: size.height/2)
        self.addChild(billy)
        
        // Set up the actions
        moveUp = SKAction.moveBy(x: 0, y: 20, duration: 0.5)
        moveDown = SKAction.moveBy(x: 0, y: -20, duration: 0.5)
        moveRight = SKAction.moveBy(x: 20, y: 0, duration: 0.5)
        moveLeft = SKAction.moveBy(x: -20, y: 0, duration: 0.5)

        let actionWait = SKAction.wait(forDuration: 2)
        let actionSpawn = SKAction.run() { [weak self] in self?.spawnObstacle() }
        let actionSequence = SKAction.sequence([actionWait,actionSpawn])
        let actionObstacleRepeat = SKAction.repeatForever(actionSequence)
        
        run(actionObstacleRepeat)
        
        scoreLabel.text = String(score)
        scoreLabel.fontColor = SKColor.black
        scoreLabel.fontSize = 96
        scoreLabel.zPosition = 150
        scoreLabel.position = CGPoint(x: size.width - size.width / 8, y: size.height - size.height / 4)
        addChild(scoreLabel)
    }
    
    // This is a function that runs about 60 times per second
    override func update(_ currentTime: TimeInterval) {
    //Check for collision between santa and the obstacles 
    checkCollisions()
        
    }
    
    override func keyDown(with event: NSEvent) {
        guard let keysPressed = event.characters else {
            return
        }
        
        if keysPressed == "w" {
            billy.texture = SKTexture(imageNamed: "Forward")
            billy.run(moveUp)
        } else if keysPressed == "s" {
        billy.texture = SKTexture(imageNamed: "Backwards")
            billy.run(moveDown)
        } else if keysPressed == "d" {
            billy.texture = SKTexture(imageNamed: "Right")
            billy.run(moveRight)
        } else if keysPressed == "a" {
            billy.texture = SKTexture(imageNamed: "Left")
            billy.run(moveLeft)
        }
    }
    
    func spawnObstacle() {
        let waspMonster = SKSpriteNode(imageNamed: "Wasp")
        
        // Define the starting position for the obstacle
        let verticalPosition = CGFloat(arc4random_uniform(UInt32(size.height)))
        let startingPoint = CGPoint(x: 0, y: verticalPosition)
        waspMonster.position = startingPoint // Set the starting position for the monster
        waspMonster.size = CGSize(width: 60, height: 60)
        
        // Give the obstacle a name
        waspMonster.name = "wasp"
        
        //Add the obstacle to the scene
        
        addChild(waspMonster)
    
        
        // Generate random Vertical movement ending position
        let randomVerticalMovement = CGFloat(arc4random_uniform(UInt32(size.height)))
        // Create ending position
        let endingPosition = CGPoint(x: size.width + 30, y: randomVerticalMovement)
        // Create action
        let waspMonsterMove = SKAction.move(to: endingPosition, duration: 5)
        
        let waspMonsterRemove = SKAction.removeFromParent()
        
        let waspSequence = SKAction.sequence([waspMonsterMove,waspMonsterRemove])
        // Run Action
        waspMonster.run(waspSequence)
    }

    // This function checks for collisions between monsters and Billy
    
    func checkCollisions() {
        // Keep track of all of the obstacles currently colliding with the hero
        var hitObstacles : [SKSpriteNode] = []
        
        enumerateChildNodes(withName: "wasp", using: { node, _ in
        
        let waspMonster = node as! SKSpriteNode
        

            if waspMonster.frame.intersects(self.billy.frame) {
        // This obstacle intersects with bILLY
            hitObstacles.append(waspMonster)
        }
        })
        // Loop over all the monsters colliding with the hero and effect them as the game design dictates.
        
        for waspMonster in hitObstacles {
            // Call a function to get rid of the monster
            monsterHit(by: waspMonster)
        }

    }

// Function that removes monster

func monsterHit(by waspMonster: SKSpriteNode) {
    
    score -= 1
    
    scoreLabel.text = String(score)
    
    waspMonster.removeFromParent()
    
    
}

}
