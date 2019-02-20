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
// First: collate the requirements anyway.
// Needs additional information for encoded behaviours in the app
// Where to add this information?
// Not complex enough to require a separate

// Mob data model basic
struct Mob {
    // Mob spawn chicken, powerups, items, barriers.

    // Some redundant with ImageAsset and the created SKSpriteNode
    let image: ImageAsset
    ///? Default decided by SKSpriteNode of SKTexture image asset size?
    /// unintended side effects?
    let size: CGFloat
    /// Decimal fraction chance of spawning 0.0..1.0
    let spawnChance: Double

//    let preferredPosition

    /// Created node from details. Could use computed var.
    let node: SKSpriteNode? = nil

    ///
    let initAnimation: SKAction? = nil

    init(
        image: ImageAsset,
        size: CGFloat = 300,
        spawnChance: Double = 0.8
    ) {
        self.image = image
        self.size = image.skTextured.size()
        self.spawnChance = 0.8
        node = image.spriteNoded

    }
}
struct lol {
    let lol = 32
}

extension MobFactory {
    static func createChicken() {

        Mob(image: Asset.chicken,
            spawnChance: 0.8,
            node: Asset.chicken.spriteNoded,
            initAnimation:
        )
    }
    static func createDuck() {

    }
    static func createEgg() {

    }
    static func createPan() {

    }
    static func createPekingRoastedChicken() {

    }
}

struct uiElement {

}
extension uiElement {
    static func createStartButton() {

    }

    static func createTitle(position: CGPoint, scale: CGFloat) {
        let titleNode = Asset.title.spriteNoded
        titleNode.position = position
        titleNode.setScale(scale)

        return
    }
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
