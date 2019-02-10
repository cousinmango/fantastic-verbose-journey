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
    // - TODO Refactor massive monolithic function
    // swiftlint:disable function_body_length
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        // - TODO: Very large multi if-else-if branching statement to refactor.
        // Large physics collision detection based on bit operations.
        // when a chicken spawns in same position as existing chicken
        
        let firstBodyIsChickenPhysics: Bool = firstBody.categoryBitMask == PhysicsCategory.chicken
        let secondBodyIsChickenPhysics: Bool = secondBody.categoryBitMask == PhysicsCategory.chicken
        let isChickenCollidingWithChicken: Bool = firstBodyIsChickenPhysics && secondBodyIsChickenPhysics
        
        // "in a world where two chickens collide..."
        let firstBodyIsTimeHourglass: (Bool) = (firstBody.categoryBitMask == PhysicsCategory.timeHourglass)
        let secondBodyIsTimeHourglass: Bool = secondBody.categoryBitMask == PhysicsCategory.timeHourglass
        
        let boopAnimation: SKAction = SKAction.moveBy( // What is this case for? Side effects of having randomly spawning nodes??
            x: 0,
            y: 10,
            duration: 0.05
        )
        
        if (isChickenCollidingWithChicken) {
            if let chicken = firstBody.node as? SKSpriteNode, let chicken2 = secondBody.node as? SKSpriteNode { //chicken2 is the initial chicken

                chicken2.run(
                    SKAction.sequence(
                        [
                            boopAnimation,
                            SKAction.removeFromParent()
                        ]
                    )
                )
                
                
                //chicken.removeFromParent()
                print("chicken hit chicken")
            }
        } else if (firstBodyIsChickenPhysics && (secondBody.categoryBitMask == PhysicsCategory.timeHourglass))
        {
            if let chicken = firstBody.node as? SKSpriteNode,
                let timeHourglass = secondBody.node as? SKSpriteNode { // pan2 is initial pan
                
                chicken.run(
                    SKAction.sequence(
                        [
                            boopAnimation,
                            SKAction.removeFromParent()
                        ]
                    )
                )
                
                print("time hit chicken")
            }
        } else if (firstBodyIsTimeHourglass && secondBodyIsTimeHourglass) {
            if let timeHourglass = firstBody.node as? SKSpriteNode,
                let timeHourglass2 = secondBody.node as? SKSpriteNode { //chicken2 is the initial chicken
                timeHourglass2.run(
                    SKAction.sequence(
                        [
                            boopAnimation,
                            SKAction.removeFromParent()
                        ]
                    )
                )
                
                print("time hit time")
            }
            
            // when pan spawns in same position as existing pan
        } else if (
            (firstBody.categoryBitMask == PhysicsCategory.fryingPan) &&
                (secondBody.categoryBitMask == PhysicsCategory.fryingPan)
            )
        {
            if let fryingPan = firstBody.node as? SKSpriteNode,
                let fryingPan2 = secondBody.node as? SKSpriteNode { // pan2 is initial pan
                
                fryingPan.removeFromParent()
                print("pan hit pan")
            }
            // when pans or chickens spawn on each other (only on smaller screens) - doesn't do anything except handle exception - DON'T REMOVE
        } else if (
            firstBodyIsChickenPhysics &&
                (secondBody.categoryBitMask == PhysicsCategory.fryingPan)
            )
        {
            if let chicken = firstBody.node as? SKSpriteNode,
                let fryingPan = secondBody.node as? SKSpriteNode {
                //print("pan hit chicken")
            }
            // chicken hit by fireball
        } else if (
            (firstBody.categoryBitMask & PhysicsCategory.chicken != 0) &&
                (secondBody.categoryBitMask & PhysicsCategory.fireball != 0)
            )
        {
            if let chicken = firstBody.node as? SKSpriteNode,
                let fireball = secondBody.node as? SKSpriteNode {
                fireball.removeFromParent()
                chicken.run(
                    SKAction.sequence(
                        [
                            SKAction.playSoundFileNamed(
                                "chickenhitSound.wav",
                                waitForCompletion: false
                            ),
                            boopAnimation,
                            SKAction.setTexture(Asset.egg.skTextured),
                            SKAction.moveBy(
                                x: 0,
                                y: -10,
                                duration: 0.1
                            )
                        ]
                    )
                )
                
                hudOverlay.addPoint()
                print("HIT CHICKEN!")
            }
            // timeHourglass hit by fireball
        } else if ((firstBody.categoryBitMask & PhysicsCategory.timeHourglass != 0) &&
            (                    secondBody.categoryBitMask & PhysicsCategory.fireball != 0
            )
            ) {
            if let timeHourglass = firstBody.node as? SKSpriteNode,
                let fireball = secondBody.node as? SKSpriteNode {
                fireball.removeFromParent()
                timeHourglass.run(
                    SKAction.sequence(
                        [
                            SKAction.playSoundFileNamed(
                                "chickenhitSound.wav",
                                waitForCompletion: false
                            ),
                            SKAction.scale(
                                to: 1.2,
                                duration: 0.05
                            ),
                            SKAction.scale(
                                to: 1,
                                duration: 0.1
                            )
                        ]
                    )
                )
                addTime()
                print("HIT timeHourglass!")
            }
            
            // pan hit by fireball
        } else if (
            (firstBody.categoryBitMask & PhysicsCategory.fryingPan != 0) &&
                (secondBody.categoryBitMask & PhysicsCategory.fireball != 0)
            ) {
            if let fryingPan = firstBody.node as? SKSpriteNode,
                let fireball = secondBody.node as? SKSpriteNode {
                fireball.run(
                    SKAction.sequence(
                        [
                            SKAction.rotate(
                                byAngle: CGFloat(Double.pi),
                                duration: 0
                            ),
                            
                            SKAction.move(
                                to: duckNode.position,
                                duration: 0.15
                            )
                        ]
                    ),
                    completion: {
                        fireball.removeFromParent()
                }
                ) // fireball bounce back
                fryingPan.run(
                    SKAction.sequence(
                        [
                            SKAction.playSoundFileNamed(
                                "panhitSound.wav",
                                waitForCompletion: false
                            ),
                            SKAction.scale(
                                to: 1.3,
                                duration: 0.05
                            ),
                            SKAction.scale(
                                to: 1,
                                duration: 0.1
                            )
                        ]
                    )
                )
                if duckSuspended == false {
                    duckHit()
                }
                print("HIT PAN!")
            }
        }
    }
}
