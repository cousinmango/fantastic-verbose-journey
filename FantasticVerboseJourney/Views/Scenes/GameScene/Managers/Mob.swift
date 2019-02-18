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

// Mob data model basic
struct Mob {
    let size: CGFloat

}

struct MobFactory {
}

struct LabelFactory {

}
extension LabelFactory {

    static func createScoreLabel(initialScore: Int, position: CGPoint) -> SKLabelNode {

        let scoreLabel = SKLabelNode(text: String(currentScore))
            scoreLabel.fontName = "DIN Alternate"
            scoreLabel.fontColor = SillyColour.textColour
            scoreLabel.fontSize = 80 // ..??
            scoreLabel.position = position

            scoreLabel.run(SKAction.sequence([SKAction.scale(to: 1, duration: 0),
            SKAction.wait(forDuration: 0.2),
            SKAction.scale(to: 1.4, duration: 0.1),
            SKAction.wait(forDuration: 0.3),
            SKAction.scale(to: 1, duration: 0.1)]))
        return scoreLabel
    }
}
