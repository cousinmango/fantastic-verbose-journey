//
//  AnimationManager.swift
//  FantasticVerboseJourney
//
//  Created by SLim on 10/2/19.
//  Copyright © 2019 CousinMango. All rights reserved.
//

import SpriteKit.SKAction

// Centralised design system for animations to aid refactoring later
struct SillyAnimations {
    static let boopAnimation: SKAction = SKAction.moveBy(
        x: 0,
        y: 10,
        duration: 0.05
    )

}
