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
class SpawnManager {
    weak var spawnScene: GameScene! // zzzzzzzz
    // let customSeedNumberGenerator
    init(spawnScene: GameScene) {
        self.spawnScene = spawnScene // for adding child.... ruh roh
    }
}

extension SpawnManager {
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - spawnMob: <#spawnMob description#>
    ///   - possibleSpawnPositions: <#possibleSpawnPositions description#>
    /// - Returns: The spawned node... probs dont need to do it like this
    func spawn(
        spawnMob: Mob,
        possibleSpawnPositions: [CGPoint] // can have an array of size 1.
    ) -> SKSpriteNode {
        let sceneSpawnSize = spawnScene.size

        // Cheating using CGSize for now.
        guard let selectedSpawnPoint = checkGetRandomSpawnPosition(
            possiblePositions: possibleSpawnPositions
        ) else {
            fatalError("randomElement failed")
        }
        let scaledSpawnPosition = getPositionScaled(
            sizeToScaleWithin: sceneSpawnSize,
            spawnPointProportion: selectedSpawnPoint
        )

        // safe immutable
        guard let node = spawnMob.node.copy() as? SKSpriteNode else {
            fatalError("Node reference type can't copy as SKSpriteNode")
        }


        node.position = scaledSpawnPosition

        // the most dangerous part.
        // spawn by adding child to the game scene.
        spawnScene.addChild(node) // NSEXception if adding same reference node to the same scene more than once.
        // initial animation to give life to the sprites
        node.run(spawnMob.initAnimation)
        // - TODO: the little jump boop animation gives a different UX feel depending on the size of the sprite
        // Boop animation should also scale depending on the size.
        //

        return node
    }

//    // -- FIXME: Cheating using CGSize when just want the x and y coordinate...
//    private func getScaledSpawn(size: CGSize, possiblePositions: [CGPoint]) -> CGSize? {
//
//
//        // recalculating unnecessarily... optimising opportunity cache
//        let scaledSpawn = size * selectedSpawnPosition
//
//        // probs won't work .. -340..+340 ???
//
//        return scaledSpawn
//    }

        
    // GGSP GOOD GAME SPAWN POINT
    /// Normalises the spawnPoint decimal percentage against the size.
    /// -- TODO: Create types to safely distinguish this behaviour.
    ///
    /// - Parameter sizeToScaleWithin: Scene size or any arbitrary rectangle.
    /// - Parameter spawnPointProportion: The decimal fraction proportion of the whole scene size. 0..<1.0 for 0 to 100% of the x and y width height values.
    /// - Returns: Returns the decimal fraction normalised against the size
    func getPositionScaled(
        sizeToScaleWithin: CGSize,
        spawnPointProportion: CGPoint
    ) -> CGPoint {
        let scaledSpawnPointX = sizeToScaleWithin.width * spawnPointProportion.x
        let scaledSpawnPointY = sizeToScaleWithin.height * spawnPointProportion.y


        // CGPoint makes more sense. Validate -300 +300 anchor point positioning coordinate system.
        let scaledSpawnPosition = CGPoint(
            x: scaledSpawnPointX,
            y: scaledSpawnPointY
        )

        return scaledSpawnPosition
    }
    private func checkGetRandomSpawnPosition(possiblePositions: [CGPoint]) -> CGPoint? {

        let invalidPositionsWarning: String = """
            Array is empty.
            Possible spawn points should be passed as a parameter.
        """
        if possiblePositions.isEmpty {
            fatalError(invalidPositionsWarning)
        }

        // Pick a random spawn position out of possible spawns.
        guard let selectedSpawnPosition = possiblePositions.randomElement() else { return nil } // can use a seed random generator for reproducibility and unit testing consistency. Conform to protocol with predicted .next()

        return selectedSpawnPosition
    }
}
