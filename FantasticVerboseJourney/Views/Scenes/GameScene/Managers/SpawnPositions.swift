//
//  SpawnPositions.swift
//  FantasticVerboseJourney
//
//  Created by SLim on 10/2/19.
//  Copyright © 2019 CousinMango. All rights reserved.
//

import struct SpriteKit.CGPoint
import struct SpriteKit.CGFloat

/// Proportional distance away from centre. 1.0 scales to the centre to the edge (from 0.5 to 0.0 and 0.5 to 1.0)
struct SpawnPositionProportion {

    // Depending on anchor maybe -1.0 < 0.0 < 1.0
    // Can replace this with enforced type... make 0 to 100 else fatal error initialisation. Static checking

    // safe padding area positioning first draft Operating on a 0.0..1.0 scale. 0 to 100% of the view.
    static private let safeMinRangeLimit = 0.2
    static private let safeMaxRangeLimit = 0.8

    // 0 to 1 assumption 0,0 anchor point (but scene probs uses 0.5, 0.5
    // could also back convert this to proper scale. renormalise the scale.
    static let northWestern = CGPoint(x: safeMinRangeLimit, y: safeMaxRangeLimit)
    static let northEastern = CGPoint(x: safeMaxRangeLimit, y: safeMaxRangeLimit)
    static let southWestern = CGPoint(x: safeMinRangeLimit, y: safeMinRangeLimit)
    static let southEastern = CGPoint(x: safeMaxRangeLimit, y: safeMinRangeLimit)
    

}

// - MARK: - WARNING: Simple linear modification requires the translation of the scaled spawn in the initialised SpawnManager.
// Hopefully stored property in the Mob object... might run into trouble here. Mutation already!
// starting with static functions to more easily move into functional programming later.
protocol PositionAdjustable {
    // Adjustment factors for scaling
    //    static let linearIncrement = 0.05
    //    static let mid = 0.5 // assumption
    static var centre: CGPoint { get }
    
    static func closerToCentre(spawnPosition: CGPoint) -> CGPoint
    
    /// Moves the coordinate a bit further from the centre by the predefined amount.
    ///
    /// - Parameter spawnPosition: Original spawn position. e.g. of the intended spawn Mob.
    /// - Returns: New point that is further from the centre by the defined amount
    static func furtherFromCentre(spawnPosition: CGPoint) -> CGPoint
}
extension SpawnPositionProportion: PositionAdjustable {
    // safe from modification.. but maybe encapsulate some of the other mob spawn properties to prevent undue non-standard modification?
    private static let linearIncrement = 0.05
    private static let mid = 0.5 // assumption
    internal static let centre = CGPoint(
        x: mid,
        y: mid
    )
    // functional style closer() closer() chain to alter by fixed amounts? does the same thing as *0.8*0.8 orrrr return a computed variable that derives from the previously defined coordinate positioning system definitions e.g. northwest
    // linear increment? vs fraction? math-e-mat-ics. 0.8*0.8 to bring closer to centre. but 0.1*0.8...
    // linear increment simplest is best to start with. 0.1 + 0.05 and 0.8 - 0.05
    // standard probably only makes sense for silly duckman four corners attack initial spawn system... sooo don't think too hard.
    // static func closer()
    static func closerToCentre(spawnPosition: CGPoint) -> CGPoint {
        
    }
    

    static func furtherFromCentre(spawnPosition: CGPoint) -> CGPoint {
        <#code#>
    }
    
    // mishmash of types continues in soft dev app v2.1
    // helper to perform calc on x and y of CGPoint
    // probably could be an extension of the base type instead... step decrement increment by given amount. (positive or negative)
    private static func increment(givenPoint: CGPoint, increment: CGFloat) -> CGPoint {
        let incrementedPoint = CGPoint(
            x: givenPoint.x + increment,
            y: givenPoint.y + increment
        )
        
        
    }


}
