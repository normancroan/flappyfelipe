//
//  GameScene.swift
//  Flappy Felipe
//
//  Created by Norman Croan on 4/10/15.
//  Copyright (c) 2015 Norman Croan. All rights reserved.
//

import SpriteKit


enum Layer: CGFloat {
    case Background
    case Foreground
    case Player
}

class GameScene: SKScene {
    
    let worldNode = SKNode()
    var playableStart: CGFloat = 0
    var playableHeight: CGFloat = 0
    
    override func didMoveToView(view: SKView) {
        addChild(worldNode)
        setupBackground()
        setupForeground()
      
    }
    
    //MARK: -Setup Methods
    
    func setupBackground() {
        
        let background = SKSpriteNode(imageNamed: "Background")
        background.anchorPoint = CGPoint(x: 0.5, y: 1.0)
        background.position = CGPoint(x: size.width/2, y: size.height)
        background.zPosition = Layer.Background.rawValue
        worldNode.addChild(background)
        
        playableStart = size.height - background.size.height
        playableHeight = background.size.height
    }
    
    func setupForeground() {
        let foreground = SKSpriteNode(imageNamed: "Ground")
        foreground.anchorPoint = CGPoint(x: 0, y: 1)
        foreground.position = CGPoint(x: 0, y: playableStart)
        foreground.zPosition = Layer.Foreground.rawValue
        worldNode.addChild(foreground)
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        
    }
    
    
    
}
