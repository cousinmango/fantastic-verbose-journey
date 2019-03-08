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

    // Hardcoding duration instead of passing a parameter
    // because design system guidelines. Try to follow a uniform UX
    // reduce cognitive load on users and keep brand continuity.
    static let scaleSizeToZeroInstant = SKAction.scale(
        to: 0,
        duration: 0
    )
    // Why use SKAction instead of directly mutating the node properties?
    // Originally all in one file GameScene as well.

    // Maybe use SKActions like a messaging protocol safely managed elsewhere.

    static let scaleSizeToZero = SKAction.scale(
        to: 0,
        duration: 0.1
    )

    static let despawnAnimated: SKAction =
        SKAction.sequence(
            [
                SillyAnimation.scaleSizeToZero,
                SKAction.removeFromParent()
            ]
    )

    // dunno if removeFromParent is all the cleanup that is required. Hmm which param to use
    static func despawn(afterDurationSeconds durationSeconds: Int) -> SKAction {
        let despawnAnimatedRemoval =        SKAction.sequence(
            [
                SKAction.wait(forDuration: TimeInterval(durationSeconds)),
                SillyAnimation.scaleSizeToZero,
                SKAction.removeFromParent()
            ]
        )

        return despawnAnimatedRemoval
    }
    static func spawnEphemeral() -> SKAction {
        let spawnDespawnSequence = SKAction.sequence(
            [
                SillyAnimation.scaleSizeToZeroInstant,
                SillyAnimation.scaleSizeToNormal,
                SillyAnimation.boopDownAnimation,
                SillyAnimation.despawn(afterDurationSeconds: 1)
            ]
        )

        return spawnDespawnSequence
    }
    // Scales to 1. Where 1 is decimal fraction of original size.
    // Need to check whether uses node size immutably, unsafe or the
    // texture/image size
    static let scaleSizeToNormal = SKAction.scale(
        to: 1,
        duration: 0.1
    )
    static let scaleSizeToNormalInstant = SKAction.scale(
        to: 1,
        duration: 0
    )

    static let scaleSizeEmbiggen = SKAction.scale(
        to: 1.2,
        duration: 0.05
    )

    static let rotateFasterSpeed = SKAction.rotate(
        byAngle: -CGFloat.pi,
        duration: 2 // feels too fast. It's much faster than MenuScene
        // Using your angle vs duration
        // Which is a more consistent way of determining speed?
        // isn't -2 * pi in 4 seconds the same as -pi in 2 seconds..?
    )
}
