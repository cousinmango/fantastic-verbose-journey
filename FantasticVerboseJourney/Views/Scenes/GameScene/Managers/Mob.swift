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
    let size: CGSize
    /// Decimal fraction chance of spawning 0.0..1.0
    let spawnChance: Double

//    let preferredPosition

    /// Created node from details. Could use computed var.
    let node: SKSpriteNode

    /// Initial animation that you want to run on spawn.
    let initAnimation: SKAction?

    init(
        image: ImageAsset,
        size: CGSize?,
        spawnChance: Double = 0.8,
        initAnimation: SKAction? = nil
    ) {
        self.image = image
        self.size = image.skTextured.size()
        self.spawnChance = 0.8
        self.node = image.spriteNoded
        self.initAnimation = nil
    }
}

struct MobFactory {

}

// - MARK: Mob creation functions.
extension MobFactory {
    static func createChicken(
        size: CGSize? = nil,
        spawnChance: Double = 0.8,
        initAnimation: SKAction? = SillyAnimation.boopDownAnimation
    ) -> Mob {
        // feels like code smell.
        let chickenMob = Mob(
            image: Asset.chicken,
            size: size, // nil size defaults to the SKTexture size.
            spawnChance: 0.8,
            initAnimation: initAnimation
        )
        return chickenMob
    }
    
    static func createDuck(
        size: CGSize? = nil,
        spawnChance: Double = 0.8,
        initAnimation: SKAction = SillyAnimation.boopDownAnimation
    ) -> Mob {
        let duckMobMainCharacter = Mob(
            image: Asset.duck,
            size: size,
            spawnChance: 1.0, // unused PC player character main.
            initAnimation: initAnimation
        )

        return duckMobMainCharacter
    }

    static func createEgg(
        size: CGSize? = nil,
        spawnChance: Double = 0.8,
        initAnimation: SKAction = SillyAnimation.boopDownAnimation
    ) -> Mob {
        let egg = Mob(
            image: Asset.egg,
            size: size,
            spawnChance: spawnChance, // unused PC player character main.
            initAnimation: initAnimation
        )

        return egg
    }

    static func createPan(
        size: CGSize? = nil,
        spawnChance: Double = 0.6,
        initAnimation: SKAction = SillyAnimation.boopDownAnimation
    ) -> Mob {

        let pan = Mob(
            image: Asset.pan,
            size: size,
            spawnChance: spawnChance,
            initAnimation: initAnimation
        )

        return pan

    }

    /// unnecessary things
    static func createPekingRoastedChicken(
        size: CGSize? = nil,
        spawnChance: Double = 0.8, // unused
        initAnimation: SKAction = SillyAnimation.boopDownAnimation
    ) -> Mob {

        let pekingRoastChicken = Mob(
            image: Asset.peking,
            size: size,
            spawnChance: spawnChance,
            initAnimation: initAnimation
        )



    }
}

struct uiElement {

}
extension uiElement {
    static func createStartButton() {

    }

    static func createTitle(
        position: CGPoint,
        scale: CGFloat
    ) -> SKSpriteNode {
        //
        let titleNode = Asset.title.spriteNoded
        titleNode.position = position
        titleNode.setScale(scale)

        return titleNode
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
