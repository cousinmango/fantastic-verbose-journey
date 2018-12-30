//
//  SKButton.swift
//  FantasticVerboseJourney
//
//  Created by SLim on 30/12/18.
//  Copyright © 2018 CousinMango. All rights reserved.
//

import SpriteKit.SKNode

class SKButtonFactory {

    // Convenience factory button. Easier for autocomplete and development to have separate convenience
    static func getButton(
        name buttonName: String = "cyanButton",
        texture: SKTexture? = nil,
        color colour: UIColor = .cyan,
        delegate buttonDelegate: SKButtonDelegate,
        size buttonSize: CGSize = CGSize(width: 400, height: 200),
        positionForScreen buttonPosition: CGPoint = CGPoint(x: 20, y: 200)
    ) -> SKButton {
        let button = SKButton(texture: texture, color: colour, size: buttonSize)

        button.name = "cyanButton"
        button.position = buttonPosition
        button.delegate = buttonDelegate

        return button
    }
}
