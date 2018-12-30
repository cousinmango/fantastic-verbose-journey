//
//  GameScene.swift
//  FantasticVerboseJourney
//
//  Created by SLim on 30/12/18.
//  Copyright © 2018 CousinMango. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    override func didMove(to view: SKView) {
        print("GameScene:: didMove() start \(view)")
        print("GameScene:: size", size)
        
        setup()
        
        
        print("GameScene:: didMove() finished")
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
}

// - MARK: Setup helpers
extension GameScene {
    
    private func setup() {
        backgroundColor = SKColor.white
        
        // Setup physics
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        
    }
}

// - MARK: Touches responders
extension GameScene {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("GameScene:: touchesBegan() start ", touches)
        
        print("GameScene:: touchesBegan() end")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("GameScene:: touchesEnded begin")
        //        guard let firstTouch = touches.first else { return }
        //        let touchLocationInScene = firstTouch.location(in: self)
    }
}

// - MARK: Physics collision detection
extension GameScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        print("Pew pew contact", contact)
        //        let bodyA = contact.bodyA
        //        let bodyB = contact.bodyB
    }
}
