//
//  SoundAsset.swift
//  FantasticVerboseJourney
//
//  Created by SLim on 12/2/19.
//  Copyright © 2019 CousinMango. All rights reserved.
//

import Foundation
public typealias AssetSoundUrlTypeAlias = URL

public enum SoundAssetFileName {
    public static let homeMusic = "homeMusic.wav"
    public static let gameMusic = "gameMusic.wav"
    public static let chickenHit = "chickenHitSound.wav"
    public static let panHit = "panHitSound.wav"
}

public enum SoundAssetUrl {
    // -- FIXME: Make it more type safe and convenient for at-call usage.
    // - MARK: URLs
    public static let homeMusicUrl: AssetSoundUrlTypeAlias? = Bundle.main.url(
        forResource: "homeMusic",
        withExtension: "wav"
    )
    public static let gameMusicUrl: AssetSoundUrlTypeAlias? = Bundle.main.url(
        forResource: "gameMusic",
        withExtension: "wav"
    )
    public static let chickenHitSound: AssetSoundUrlTypeAlias? = Bundle.main.url(
        forResource: "chickenHitSound",
        withExtension: "wav"
    )
    public static let panHitSound: AssetSoundUrlTypeAlias? = Bundle.main.url(
        forResource: "panHitSound",
        withExtension: "wav"
    )
}
