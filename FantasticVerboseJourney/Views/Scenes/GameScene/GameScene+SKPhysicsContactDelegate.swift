//
//  GameScene+SKPhysicsContactDelegate.swift
//  FantasticVerboseJourney
//
//  Created by SLim on 10/2/19.
//  Copyright © 2019 CousinMango. All rights reserved.
//

import SpriteKit

// - MARK: Physics collision detection
extension GameScene: SKPhysicsContactDelegate {

    func didBegin(_ contact: SKPhysicsContact) {
        
        // Random dodgy code.
        // ?? Validate this. Why does categoryBitMask determine which is "first"
        // Stable? Seems volatile or unintended behaviour-prone.
        let aIsFirst: Bool = contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask
        let bIsSecond: Bool = aIsFirst // self-describing vars...
        let firstBody: SKPhysicsBody = aIsFirst ? contact.bodyA : contact.bodyB
        let secondBody: SKPhysicsBody = bIsSecond ? contact.bodyB : contact.bodyA

        hitCollisionBehaviourCalcDoStuff(firstBody, secondBody)
    }
    
    // - TODO Refactor massive monolithic function
    // swiftlint:disable function_body_length cyclomatic_complexity
    fileprivate func hitCollisionBehaviourCalcDoStuff(_ firstBody: SKPhysicsBody, _ secondBody: SKPhysicsBody) {
        
    }
    
}
