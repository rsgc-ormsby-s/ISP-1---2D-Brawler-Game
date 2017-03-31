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
        let Billy = SKSpriteNode(imageNamed: "Backwards")
        Billy.position = CGPoint(x: size.width / 2, y: size.height/2)
        self.addChild(Billy)
    }
    
}
