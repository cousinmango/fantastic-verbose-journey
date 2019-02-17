//
//  SillyActionSound.swift
//  FantasticVerboseJourney
//
//  Created by SLim on 12/2/19.
//  Copyright © 2019 CousinMango. All rights reserved.
//

import SpriteKit.SKAction

struct SillyActionSound {
    static let homeMusic = SKAction.playSoundFileNamed(
        SoundAssetFileName.homeMusic,
        waitForCompletion: false
    )
    static let gameMusic = SKAction.playSoundFileNamed(
        SoundAssetFileName.gameMusic,
        waitForCompletion: false
    )
    static let chickenHit = SKAction.playSoundFileNamed(
        SoundAssetFileName.chickenHit,
        waitForCompletion: false
    )
    static let panHit = SKAction.playSoundFileNamed(
        SoundAssetFileName.panHit,
        waitForCompletion: false
    )
}
