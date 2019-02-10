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
        // - TODO: Very large multi if-else-if branching statement to refactor.
        // Large physics collision detection based on bit operations.
        // when a chicken spawns in same position as existing chicken

        let firstBodyIsChickenPhysics: Bool = firstBody.categoryBitMask == PhysicsCategory.chicken
        let secondBodyIsChickenPhysics: Bool = secondBody.categoryBitMask == PhysicsCategory.chicken
        let isChickenCollidingWithChicken: Bool = firstBodyIsChickenPhysics && secondBodyIsChickenPhysics

        // "in a world where two chickens collide..."
        let firstBodyIsTimeHourglass: (Bool) = (firstBody.categoryBitMask == PhysicsCategory.timeHourglass)
        let secondBodyIsTimeHourglass: Bool = secondBody.categoryBitMask == PhysicsCategory.timeHourglass

        let firstBodyIsFryingPan: Bool = firstBody.categoryBitMask == PhysicsCategory.fryingPan
        let secondBodyIsFryingPan: Bool = secondBody.categoryBitMask == PhysicsCategory.fryingPan
        let firstBodyMaskBitAndTimeHourglass: UInt32 = firstBody.categoryBitMask & PhysicsCategory.timeHourglass
        let secondBodyMaskBitAndFryingPan: UInt32 = secondBody.categoryBitMask & PhysicsCategory.fireball

        if (isChickenCollidingWithChicken) {
            print("Hit: 1 chicken 2 chicken")

            guard let chicken = firstBody.node as? SKSpriteNode else { return }
            guard let chicken2 = secondBody.node as? SKSpriteNode else { return }
            // chicken2 is the initial chicken
            print("remove chicken2")
            chicken2.run(
                SKAction.sequence(
                    [
                        SillyAnimation.boopUpAnimation,  // What is this case for? Side effects of having randomly spawning nodes??
                        SKAction.removeFromParent()
                    ]
                )
            )

            // chicken.removeFromParent()

        } else if (firstBodyIsChickenPhysics && secondBodyIsTimeHourglass) {
            print("Hit: 1 chicken 2 time")

            guard let chicken = firstBody.node as? SKSpriteNode else { return }
            guard let timeHourglass = secondBody.node as? SKSpriteNode else { return }

            // pan2 is initial pan
            chicken.run(
                SKAction.sequence(
                    [
                        SillyAnimation.boopUpAnimation,  // What is this case for? Side effects of having randomly spawning nodes??
                        SKAction.removeFromParent()
                    ]
                )
            )

        } else if (firstBodyIsTimeHourglass && secondBodyIsTimeHourglass) {
            print("Hit: 1 time 2 time")

            guard let timeHourglass = firstBody.node as? SKSpriteNode else { return }
            guard let timeHourglass2 = secondBody.node as? SKSpriteNode else { return }

            // chicken2 is the initial chicken
            timeHourglass2.run(
                SKAction.sequence(
                    [
                        SillyAnimation.boopUpAnimation,
                        SKAction.removeFromParent()
                    ]
                )
            )

            // when pan spawns in same position as existing pan
        } else if (firstBodyIsFryingPan && secondBodyIsFryingPan) {
            print("Hit: 1 fryingPan 2 fryingPan")

            guard let fryingPan = firstBody.node as? SKSpriteNode else { return }
            guard let fryingPan2 = secondBody.node as? SKSpriteNode else { return }
            // pan2 is initial pan

            fryingPan.removeFromParent()

            // when pans or chickens spawn on each other (only on smaller screens) - doesn't do anything except handle exception - DON'T REMOVE
        } else if (firstBodyIsChickenPhysics && secondBodyIsFryingPan) {
            print("Hit: 1 chicken 2 fryingPan")
            guard let chicken = firstBody.node as? SKSpriteNode else { return }
            guard let fryingPan = secondBody.node as? SKSpriteNode else { return }
            
        } else if (
            (firstBody.categoryBitMask & PhysicsCategory.chicken != 0) && (secondBody.categoryBitMask & PhysicsCategory.fireball != 0)
            ) {
            // chicken hit by fireball
            print("Hit: 1 bANDchickenNotZero 2 bANDFireballNotZero")
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
                            SillyAnimation.boopUpAnimation,
                            SKAction.setTexture(Asset.egg.skTextured),
                            SillyAnimation.boopDownAnimation
                        ]
                    )
                )

                hudOverlay.addPoint()
                print("HIT CHICKEN!")
            }
            
        } else if (firstBodyMaskBitAndTimeHourglass != 0 && secondBodyMaskBitAndFryingPan != 0) {
            // timeHourglass hit by fireball

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
        } else if ((firstBody.categoryBitMask & PhysicsCategory.fryingPan != 0) &&
                (secondBody.categoryBitMask & PhysicsCategory.fireball != 0)
            ) {
            print("??something1st hit fryingpan, 2nd thing not a fireball??")
            let firstBodyBitAndFryingPan = firstBody.categoryBitMask & PhysicsCategory.fryingPan
            print(firstBody.categoryBitMask, PhysicsCategory.fryingPan, "BIT AND", firstBodyBitAndFryingPan)
            guard let fryingPan = firstBody.node as? SKSpriteNode else { return }
            guard let fireball = secondBody.node as? SKSpriteNode else { return }
            
            /// Orientation of fireball is rotated 180 degrees
            /// pi3.14 radians is 180 degrees.
            /// Fireball continues its velocity.
            /// Rotate by pi rotates 180deg 1. fireball -> pan direction
            /// 2. reflected back -> duck direction

            let flipRotateBack: SKAction = SKAction.rotate(
                    byAngle: CGFloat(Double.pi),
                    duration: 0
            )
            let moveTowardsDuck: SKAction = SKAction.move(
                to: duckNode.position,
                duration: 0.15
            )
            
            // bounce the fireball back and despawn
            fireball.qRun(
                actions: flipRotateBack, moveTowardsDuck,
                onCompletion: { fireball.removeFromParent()
                    // ? using this despawn instead of the physics collision...
                }
            )
            
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
                duckHitIntoARoastPekingDuck()
            }
            print("HIT PAN!")

        }
    }
}
