//
//  AnimationManager.swift
//  FantasticVerboseJourney
//
//  Created by SLim on 10/2/19.
//  Copyright © 2019 CousinMango. All rights reserved.
//

import SpriteKit.SKAction

// Centralised design system for animations to aid refactoring later
struct SillyAnimation {
    static let boopUpAnimation: SKAction = SKAction.moveBy(
        x: 0,
        y: 10,
        duration: 0.05
    )
    
    // Design system: Make it look like the duck spawns by dropping onto the
    // `floor` a few pixels.
    static let boopDownAnimation: SKAction = SKAction.moveBy(
        x: 0,
        y: -10,
        duration: 0.1
        
    )
}
