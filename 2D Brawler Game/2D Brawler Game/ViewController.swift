//
//  ViewController.swift
//  2D Brawler Game
//
//  Created by Student on 2017-03-02.
//  Copyright © 2017 Student. All rights reserved.
//

import Cocoa
import SpriteKit
import GameplayKit

class ViewController: NSViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let scene = GameScene(size: CGSize(width:800, height: 600))
        
        let skView = SKView(frame:NSRect(origin:CGPoint(x:0, y: 0), size: CGSize(width: 800, height: 600)))
        
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        view.addSubview(skView)
        scene.scaleMode = .aspectFit
        skView.presentScene(scene)
        
        skView.showsPhysics = true
        
            }
    override func viewDidAppear() {
        super.viewDidAppear()
    }
    
    override var representedObject: Any? {
        didSet {
        }
    }

}
