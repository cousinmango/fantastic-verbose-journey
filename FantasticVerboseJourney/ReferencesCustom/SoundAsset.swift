//
//  SoundAsset.swift
//  FantasticVerboseJourney
//
//  Created by SLim on 12/2/19.
//  Copyright © 2019 CousinMango. All rights reserved.
//

import Foundation

struct SoundAsset {
    // -- FIXME: Make it more type safe and convenient for at-call usage.
    static let homeMusic = Bundle.main.url(
        forResource: "homeMusic",
        withExtension: "wav"
    )
    static let musicURL = Bundle.main.url(
        forResource: "gameMusic",
        withExtension: "wav"
    )
}
