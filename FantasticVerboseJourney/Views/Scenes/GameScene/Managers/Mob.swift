//
//  Mob.swift
//  FantasticVerboseJourney
//
//  Created by SLim on 10/2/19.
//  Copyright © 2019 CousinMango. All rights reserved.
//

import Foundation
import SpriteKit
// Characteristics
// Common animation
// See design system commonalities?


// Probably shouldn't keep the Node data inside here...

// Mob data model basic
struct Mob {
    // Mob spawn chicken, powerups, items, barriers.

    ///? Default decided by SKSpriteNode of SKTexture image asset size?
    /// unintended side effects?
    let size: CGFloat = 0
    /// Decimal fraction chance of spawning 0.0..1.0
    let spawnChance: Double = 1.0


    let node: SKSpriteNode
}

struct MobFactory {

}
extension MobFactory {

}

// Probably unnecessary
//struct SpriteFactory {
//
//    static func createChickenSpriteNode() -> SKSpriteNode {
//        return Asset.chicken.spriteNoded
//        // return SKSpriteNode(texture: Asset.chicken.skTextured)
//    }
//}


struct LabelFactory {

}
extension LabelFactory {

    static func createScoreLabel(initialScore: Int, position: CGPoint) -> SKLabelNode {

        let scoreText: String = String(initialScore)

        let scoreLabel = SKLabelNode(text: scoreText)
        scoreLabel.fontName = SillyText.fontName
        scoreLabel.fontColor = SillyColour.textColour
        scoreLabel.fontSize = SillyText.FontSize.large.cgFloat // ..??
        scoreLabel.position = position

        scoreLabel.run(
            SKAction.sequence(
                [   // rip
                    SKAction.scale(to: 1,   duration:       0),
                    SKAction.wait(       forDuration:       0.2),
                    SKAction.scale(to: 1.4, duration:       0.1),
                    SKAction.wait(       forDuration:       0.3),
                    SKAction.scale(to: 1,   duration:       0.1)
                ]
            )
        )
        return scoreLabel
    }
}
