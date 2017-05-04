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
    
    //Create variable for the hero (Billy)
    var billy = SKSpriteNode()
    
    //Variable to turn off parts of the code under certain circumstances (Ex. Game Over Screen)
    var gameIsActive = true
    
    //Create Variable for Game Over Label
    let gameOver = SKLabelNode(fontNamed: "Helvetica-Bold")
    
    //Create variable for the Score Label
    let scoreLabel = SKLabelNode(fontNamed: "Helvetica-Bold")
    
    //Create variable for the Timer Label
    
    let timerLabel = SKLabelNode(fontNamed: "Helvetica-Bold")
    
    //Declare the starting score ammount
    var score = 3
    
    //Declare the timer starting amount
    var startTime = 0
    
    var timeSoFar = 0

    // Declare billy movements in variables.
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
        
        //Create the possible movement actions for Billy
        moveUp = SKAction.moveBy(x: 0, y: 20, duration: 0.5)
        moveDown = SKAction.moveBy(x: 0, y: -20, duration: 0.5)
        moveRight = SKAction.moveBy(x: 20, y: 0, duration: 0.5)
        moveLeft = SKAction.moveBy(x: -20, y: 0, duration: 0.5)
        

        let actionWait = SKAction.wait(forDuration: 2)
        let actionSpawn = SKAction.run() { [weak self] in self?.spawnObstacle() }
        let actionSequence = SKAction.sequence([actionWait,actionSpawn])
        let actionObstacleRepeat = SKAction.repeatForever(actionSequence)
        
        run(actionObstacleRepeat)
        
        //Create the score label
        scoreLabel.text = String(score)
        scoreLabel.fontColor = SKColor.yellow
        scoreLabel.fontSize = 96
        scoreLabel.zPosition = 150
        scoreLabel.position = CGPoint(x: size.width - size.width / 8, y: size.height - size.height / 4)
        addChild(scoreLabel)
        
        //Create the Game Over screen words at the end
        gameOver.text = String("Game Over")
        gameOver.fontColor = SKColor.black
        gameOver.fontSize = 96
        gameOver.zPosition = 150
        gameOver.position = CGPoint(x: size.width / 2, y: size.height / 2)
        gameOver.isHidden = true
        
        //Create the Timer
        
        timerLabel.text = String(timeSoFar)
        timerLabel.fontColor = SKColor.red
        timerLabel.fontSize = 96
        timerLabel.zPosition = 150
        timerLabel.position = CGPoint(x: size.width - size.width + 100, y: size.height - size.height / 4)
        addChild(timerLabel)
    }
    
    
    
    // This is a function that runs about 60 times per second
    override func update(_ currentTime: TimeInterval) {
    //Check for collision between Billy and the obstacles
        
        // Check to see if the game just started
        if gameIsActive == true {
        if startTime == 0 {
            startTime = Int(currentTime)
        } else {
            let now = Int(currentTime) - startTime
            
            // Only update the timeSoFar and the timer label when the timeSoFar is not "now"
            if timeSoFar != now {
                timeSoFar = now
                timerLabel.text = String(now)
            }
        }
        }
        checkCollisions()
    }
    
    
    
    override func keyDown(with event: NSEvent) {
        guard let keysPressed = event.characters else {
            return
        }
        //If a certain key is pressed, move in the assigned direction, creating movement commands and the textures are changed according to the direction.
        
        if gameIsActive == true {
            
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
    }
    
    
    
    //Create a function for spawning monsters
    func spawnObstacle() {
        
        if gameIsActive == true {
            
            //Declare the Wasp Monster
        let waspMonster = SKSpriteNode(imageNamed: "Wasp")
        
        // Define the starting position for the monster
        let verticalPosition = CGFloat(arc4random_uniform(UInt32(size.height)))
        let startingPoint = CGPoint(x: 0, y: verticalPosition)
        waspMonster.position = startingPoint // Set the starting position for the monster
        waspMonster.size = CGSize(width: 60, height: 60)
        
        // Give the monster a name
        waspMonster.name = "wasp"
        
        //Add the obstacle to the scene
        
        addChild(waspMonster)
    
        
        // Generate random Vertical movement ending position
            let randomDuration = (Double(arc4random_uniform(UInt32(10))))

        let randomVerticalMovement = CGFloat(arc4random_uniform(UInt32(size.height)))
        // Create ending position
        let endingPosition = CGPoint(x: size.width + 30, y: randomVerticalMovement)
        // Create action
            let waspMonsterMove = SKAction.move(to: endingPosition, duration: randomDuration)
        
        let waspMonsterRemove = SKAction.removeFromParent()
        
        let waspSequence = SKAction.sequence([waspMonsterMove,waspMonsterRemove])

        // Run Action
        waspMonster.run(waspSequence, withKey: "moveWasp")
        }
    }

    
    
    // This function checks for collisions between monsters and Billy
    
    func checkCollisions() {
        // Keep track of all of the monsters currently colliding with the hero
        
        if billy.position.x > size.width || billy.position.x < 0 {
            billy.position = CGPoint(x: size.width/2, y: size.height/2)
        }
        
        if billy.position.y > size.height || billy.position.y < 0 {
            billy.position = CGPoint(x: size.width/2, y: size.height/2)
        }
        var hitObstacles : [SKSpriteNode] = []
        
        enumerateChildNodes(withName: "wasp", using: { node, _ in
        
        let waspMonster = node as! SKSpriteNode

            if waspMonster.frame.intersects(self.billy.frame) {
        // This obstacle intersects with Billy
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
    
    //Set of Statements that Change Color of scoreLabel depending on the score number
    if score == 2 {
        scoreLabel.fontColor = SKColor.orange
    } else if score == 1 {
        scoreLabel.fontColor = SKColor.red
    } else if score == 0 {
        scoreLabel.fontColor = SKColor.black
        
        //Create game over screen when at 0
        //Add Child to the Scene
        addChild(gameOver)

        //Action Sequence for Game Over Ending Screen
        let gameOverMakeVisible = SKAction.unhide()
        let gameOverFadeIn = SKAction.fadeIn(withDuration: 1)
        let gameOverDelay = SKAction.wait(forDuration: 2)
        let gameOverSequence = SKAction.sequence([gameOverMakeVisible, gameOverFadeIn, gameOverDelay])
        
        gameOver.run(gameOverSequence)
        gameIsActive = false
        
        // Stop the wasps
        for node in self.children {
            if let nodeName = node.name {
                if nodeName == "wasp" {
                    node.removeAction(forKey: "moveWasp")
                }
            }
        }
        
        
    }
    
}

}
