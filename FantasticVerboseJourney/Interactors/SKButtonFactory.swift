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
        size buttonSize: CGSize = CGSize(width: 504, height: 200), // hard coded size TODO: need to fix
        positionForScreen buttonPosition: CGPoint = CGPoint(x: 0, y: 0)
    ) -> SKButton {
        let button = SKButton(texture: texture, color: colour, size: buttonSize)

        button.name = "cyanButton"
        button.position = buttonPosition
        button.size = buttonSize
        button.delegate = buttonDelegate

        return button
    }
}
