//
//  AssetsImagesRefAdaptor.swift
//  FantasticVerboseJourney
//
//  Created by SLim on 6/2/19.
//  Copyright © 2019 CousinMango. All rights reserved.
//

import Foundation
import SpriteKit.SKTexture

/// Strings or SKSprite SKTexture UIImage adaptation
/// Future revision should be more permanent.. e.g. change SwiftGen template to use
/// extensible Struct static vars instead of enum?
/// Or just alter the template to include a compatible asset reference
/// that doesn't require an extra wrapper step for use elsewhere.
/// - Warning: If not initialising, SKTexture requires explicitly set size if you
/// assign to `SKSpriteNode.texture`

protocol SKTexturable {
    // Extensible computed property to utilise the SwiftGen-generated assets ref
    var skTextured: SKTexture { get }
}

extension ImageAsset: SKTexturable {
    // Extensible computed property to utilise the SwiftGen-generated assets ref
    var skTextured: SKTexture {
        return SKTexture(image: self.image)
    }
}

protocol SKSpritable: SKTexturable {
    var spriteNoded: SKSpriteNode { get }
}

extension ImageAsset: SKSpritable {
    var spriteNoded: SKSpriteNode {
        return SKSpriteNode(texture: self.skTextured)
    }

}
//private final class BundleToken {}
