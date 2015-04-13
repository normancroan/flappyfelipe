//
//  GameScene.swift
//  Flappy Felipe
//
//  Created by Norman Croan on 4/10/15.
//  Copyright (c) 2015 Norman Croan. All rights reserved.
//

import SpriteKit
import AVFoundation


enum Layer: CGFloat {
    case Background
    case Foreground
    case Player
}

class GameScene: SKScene {
    
    let kGravity: CGFloat = -1500.0
    let kImpulse: CGFloat = 400.0
    
    let worldNode = SKNode()
    var playableStart: CGFloat = 0
    var playableHeight: CGFloat = 0
    let player = SKSpriteNode(imageNamed: "Bird0")
    var lastUpdateTime: NSTimeInterval = 0
    var dt: NSTimeInterval = 0
    var playerVelocity = CGPoint.zeroPoint
    
    
    let dingAction = SKAction.playSoundFileNamed("ding.wav", waitForCompletion: false)
    let flapAction = SKAction.playSoundFileNamed("flapping.wav", waitForCompletion: false)
    let whackAction = SKAction.playSoundFileNamed("whack.wav", waitForCompletion: false)
    let fallingAction = SKAction.playSoundFileNamed("falling.wav", waitForCompletion: false)
    let hitGroundAction = SKAction.playSoundFileNamed("hitGround.wav", waitForCompletion: false)
    let popAction = SKAction.playSoundFileNamed("pop.wav", waitForCompletion: false)
    let coinAction = SKAction.playSoundFileNamed("coin.wav", waitForCompletion: false)
    
    override func didMoveToView(view: SKView) {
        addChild(worldNode)
        setupBackground()
        setupForeground()
        setupPlayer()
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
    
    func setupPlayer() {
        
        player.position = CGPoint(x: size.width * 0.2, y: playableHeight * 0.4 + playableStart)
        player.zPosition = Layer.Player.rawValue
        worldNode.addChild(player)
        
        
    }
   //MARK: - Gameplay
    
    func flapPlayer() {
    //Apply Sound
        runAction(flapAction)
        
    //Apply Impulse
        playerVelocity = CGPoint(x: 0, y: kImpulse)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        flapPlayer()
    }
   //MARK: - Updates
    override func update(currentTime: CFTimeInterval) {
        if lastUpdateTime > 0 {
            dt = currentTime - lastUpdateTime
        } else {
            dt = 0
        }
        lastUpdateTime = currentTime
        
        updatePlayer()
    }
    
    func updatePlayer() {
        
        // Apply gravity
        let gravity = CGPoint(x: 0, y: kGravity)
        let gravityStep = gravity * CGFloat(dt)
        playerVelocity += gravityStep
        
        // Apply velocity
        let velocityStep = playerVelocity * CGFloat(dt)
        player.position += velocityStep
        
        // Temprary halt when hits ground
        if player.position.y - player.size.height/2 < playableStart {
            player.position = CGPoint(x: player.position.x, y: playableStart + player.size.height/2)
        }
        
    }
    
}
