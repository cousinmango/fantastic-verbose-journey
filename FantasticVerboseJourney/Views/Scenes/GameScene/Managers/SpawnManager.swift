//
//  SpawnManager.swift
//  FantasticVerboseJourney
//
//  Created by SLim on 10/2/19.
//  Copyright © 2019 CousinMango. All rights reserved.
//

import SpriteKit
// Only need to know the initial position? Propotional coordinate system

//extension CGSize {
//    static func *(point: CGSize, scalar: CGFloat) -> CGSize {
//        // multiplied proportion.
//        return CGSize(
//            width: point.width * scalar,
//            height: point.height * scalar
//        )
//    }
//}
struct SpawnManager {

    // let customSeedNumberGenerator
}

extension SpawnManager {
    func spawn(
        spawnScene: GameScene,
        mob: Mob,
        positions: CGPoint...
    ) {
        let size = spawnScene.size

        
        // Pick a random spawn position out of possible spawns.
        guard let selectedSpawnPosition = positions.randomElement() else { return }// can use a seed random generator for reproducibility and unit testing consistency. Conform to protocol with predicted .next()

        // recalculating unnecessarily... optimising opportunity cache
        let scaledSpawn = size * selectedSpawnPosition


    }

    // not sure
    func lol(spawnScene: SKScene) {

    }
}
