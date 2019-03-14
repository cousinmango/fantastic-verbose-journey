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
    fileprivate func doMobFireballReactionsSeries(otherBody recipientBody: SKPhysicsBody, projectileBody: SKPhysicsBody) {
        // Fireballs should not collide with each other (first and second body) based on initial config.

        // categories are set only to allow chicken and pan to get hit.
        // and activated against fireball.

        // order the logic by prioritising early escape and finish execution

        // if pan
        // - TODO: Implement OOD or basic denormalised data struct to start
        // Best to try to reuse the SKSpriteNode as much as possible.
        // - TODO: Replace identification node physicscategory with node.name

        if recipientBody.categoryBitMask == PhysicsCategory.fryingPan {
            // bounce back
            guard let projectile = projectileBody.node else { return }
            guard let fryingPan = recipientBody.node else { return }

            // 1. Animate pan on hit
            let fryingPanResponsiveHitBoopAnimation = SKAction.sequence(
                [
                    SillyAnimation.scaleSizeEmbiggen,
                    SillyAnimation.scaleSizeToNormal
                ]
            )
            fryingPan.run(fryingPanResponsiveHitBoopAnimation)

            // rotate the fireball back at the centre
            // delete fireball after completing the action (presumably hitting centre)
            // completion handler is clearer more declarative.


            //zzzzzz back to attack the chicken... Wonder if can do cool curved things like in bloooooon td

            let centrePoint = spawnManager.getPositionScaled(
                sizeToScaleWithin: size,
                spawnPointProportion: CGPoint(x: 0.5, y: 0.5)
            )
            let aShortInterval = 0.15

            let rotate180Instant = SKAction.rotate(byAngle: CGFloat.pi, duration: 0)
            let shootProjectileBack = SKAction.move(to: centrePoint, duration: aShortInterval)

            let projectileReflect = SKAction.sequence(
                [
                    rotate180Instant,
                    shootProjectileBack
                ]
            )
            let despawnProjectile = { projectile.removeFromParent() } // superfluous wrap
            projectile.run(
                projectileReflect,
                completion: despawnProjectile
            )


        }
    }

    fileprivate func hitCollisionBehaviourCalcDoStuff(_ firstBody: SKPhysicsBody, _ secondBody: SKPhysicsBody) {

        let firstIsFireball = firstBody.categoryBitMask == PhysicsCategory.fireball
        let secondIsFireball = secondBody.categoryBitMask == PhysicsCategory.fireball

        if firstIsFireball {
            // remove (secondBody)
            doMobFireballReactionsSeries(otherBody: secondBody, projectileBody: firstBody)
            // return

        } else if secondIsFireball {
            // the recipient body that was hit by the fireball is therefore the other body in the SKPhysicsContactDelegate
            // remove firstBody
            doMobFireballReactionsSeries(otherBody: firstBody, projectileBody: secondBody)


        }


    }

}
