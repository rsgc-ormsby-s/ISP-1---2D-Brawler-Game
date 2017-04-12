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
        
        // Invoke the spawn function
        spawnObstacle()
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
        
        let startingPoint = CGPoint(x: 0, y: 40)
        waspMonster.position = startingPoint // Set the starting position for the monster
        waspMonster.size = CGSize(width: 60, height: 60)
        //Add the obstacle to the scene
        
        addChild(waspMonster)
        
        // Move 
        
        let endingPosition = CGPoint(x: size.width, y: 40)
        let waspMonsterMove = SKAction.move(to: endingPosition, duration: 5)
        waspMonster.run(waspMonsterMove)
    }
}
