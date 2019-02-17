//
//  SKSpriteNode+ConvenientActionSequenceRunnable.swift
//  FantasticVerboseJourney
//
//  Created by SLim on 10/2/19.
//  Copyright © 2019 CousinMango. All rights reserved.
//

import SpriteKit.SKSpriteNode

// Convenience function for running ad hoc sequences of SKActions for clarity.
// Wrapper removes an extra nesting function at place of function call.
extension SKSpriteNode {
    func qRun(actions: SKAction...) {
        let sequenceOfActionsAsAction = SKAction.sequence(actions)
        self.run(sequenceOfActionsAsAction)
    }

    func qRun(actions: SKAction..., onCompletion completion: @escaping () -> Void) {
        let sequenceOfActionsAsAction = SKAction.sequence(actions)
        self.run(
            sequenceOfActionsAsAction,
            completion: completion
        )

    }
}

//// Example equivalence
//Before:
//        fireball.run(
//            SKAction.sequence(
//                [
//                    flipRotateBack,
//                    moveTowardsDuck
//                ]
//            ),
//            completion: {
//                fireball.removeFromParent()
//            }
//        ) // fireball bounce back
//        fryingPan.run(
//            SKAction.sequence(
//                [
//                    SKAction.playSoundFileNamed(
//                        "panHitSound.wav",
//                        waitForCompletion: false
//                    ),
//                    SKAction.scale(
//                        to: 1.3,
//                        duration: 0.05
//                    ),
//                    SKAction.scale(
//                        to: 1,
//                        duration: 0.1
//                    )
//                ]
//            )
//        )
//After:
//        fireball.qRun( flipRotateBack, moveTowardsDuck )
//        fryingPan.run(
//            SKAction.playSoundFileNamed(
//                "panHitSound.wav",
//                waitForCompletion: false
//            ),
//            SKAction.scale(
//                to: 1.3,
//                duration: 0.05
//            ),
//                SKAction.scale(
//                to: 1,
//                duration: 0.1
//            )
//        )
