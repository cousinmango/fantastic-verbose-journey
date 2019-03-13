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
        print("GameScene Physics:: didBegin()")
        // Random dodgy code.
        // ?? Validate this. Why does categoryBitMask determine which is "first"
        // Stable? Seems volatile or unintended behaviour-prone.
        let aIsFirst: Bool = contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask
        let bIsSecond: Bool = aIsFirst // self-describing vars...
        let firstBody: SKPhysicsBody = aIsFirst ? contact.bodyA : contact.bodyB
        let secondBody: SKPhysicsBody = bIsSecond ? contact.bodyB : contact.bodyA

        print("physicsContact at point: \(contact.contactPoint)")
        hitCollisionBehaviourCalcDoStuff(firstBody, secondBody)
    }

    // - TODO Refactor massive monolithic function
    // swiftlint:disable function_body_length cyclomatic_complexity
    fileprivate func hitCollisionBehaviourCalcDoStuff(_ firstBody: SKPhysicsBody, _ secondBody: SKPhysicsBody) {

        let firstIsFireball = firstBody.categoryBitMask == PhysicsCategory.fireball
        let secondIsFireball = secondBody.categoryBitMask == PhysicsCategory.fireball

        if firstIsFireball {
            // Fireballs should not collide with each other (first and second body)
            // categories are set only to allow chicken and pan to get hit.
            // and activated against fireball.

            // remove secondBody
        } else if secondIsFireball {
            // remove firstBody

        }
        print("1 fireball \(firstIsFireball)2 fireball \(secondIsFireball)")

        let firstBit = firstBody.categoryBitMask
        let secondBit = secondBody.categoryBitMask

        let andBit = firstBit & secondBit
        let orBit = firstBit | secondBit

        let firstChicken = firstBody.categoryBitMask == PhysicsCategory.chicken
        let secondChicken = secondBody.categoryBitMask == PhysicsCategory.chicken

        if firstChicken {
            print(" firstChicken \(firstChicken)")
        }

        if secondChicken {
            print(" secondChicken \(secondChicken)")
        }

        print("firstBit \(firstBit) secondBit \(secondBit) andBit \(andBit) orBit \(orBit)")


    }

}
