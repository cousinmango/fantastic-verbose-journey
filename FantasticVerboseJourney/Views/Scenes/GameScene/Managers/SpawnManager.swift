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
        possibleSpawnPositions: [CGPoint] // can have an array of size 1.
    ) {
        let size = spawnScene.size

        // Cheating using CGSize for now.
        guard let scaledSpawn = getScaledSpawn(
            size: size,
            possiblePositions: possibleSpawnPositions
        ) else { return }
        let node = mob.node

        // CGPoint makes more sense. Validate -300 +300 anchor point positioning coordinate system.
        let scaledSpawnPosition = CGPoint(x: scaledSpawn.width, y: scaledSpawn.height)

        node.position = scaledSpawnPosition

        // spawn
        spawnScene.addChild(mob.node)

    }

    // -- FIXME: Cheating using CGSize when just want the x and y coordinate...
    private static func getScaledSpawn(size: CGSize, possiblePositions: [CGPoint]) -> CGSize? {
        let invalidPositionsWarning: String = """
            Array is empty.
            Possible spawn points should be passed as a parameter.
        """
        if possiblePositions.isEmpty {
            fatalError(invalidPositionsWarning)
        }

        // Pick a random spawn position out of possible spawns.
        guard let selectedSpawnPosition = possiblePositions.randomElement() else { return nil } // can use a seed random generator for reproducibility and unit testing consistency. Conform to protocol with predicted .next()



        // recalculating unnecessarily... optimising opportunity cache
        let scaledSpawn = size * selectedSpawnPosition

        // probs won't work .. -340..+340 ???

        return scaledSpawn
    }

}
