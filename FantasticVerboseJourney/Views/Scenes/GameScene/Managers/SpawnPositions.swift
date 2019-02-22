//
//  SpawnPositions.swift
//  FantasticVerboseJourney
//
//  Created by SLim on 10/2/19.
//  Copyright © 2019 CousinMango. All rights reserved.
//

import struct SpriteKit.CGPoint

/// Proportional distance away from centre. 1.0 scales to the centre to the edge (from 0.5 to 0.0 and 0.5 to 1.0)
struct SpawnPositionProportion {

    // Depending on anchor maybe -1.0 < 0.0 < 1.0
    // Can replace this with enforced type... make 0 to 100 else fatal error initialisation. Static checking

    // safe padding area positioning first draft
    static private let safeMinRangeLimit = 0.2
    static private let safeMaxRangeLimit = 0.8

    // 0 to 1 assumption 0,0 anchor point (but scene probs uses 0.5, 0.5
    // could also back convert this to proper scale. renormalise the scale.
    static let northWestern = CGPoint(x: safeMinRangeLimit, y: safeMaxRangeLimit)
    static let northEastern = CGPoint(x: safeMaxRangeLimit, y: safeMaxRangeLimit)
    static let southWestern = CGPoint(x: safeMinRangeLimit, y: safeMinRangeLimit)
    static let southEastern = CGPoint(x: safeMaxRangeLimit, y: safeMinRangeLimit)
    

}

// starting with static functions to more easily move into functional programming later.
protocol PositionAdjustable {
    static func closerToMid(spawnPosition: CGPoint) -> CGPoint
    
    static func furtherFromMid(spawnPosition: CGPoint) -> CGPoint
}
extension SpawnPositionProportion: PositionAdjustable {
    
    // functional style closer() closer() chain to alter by fixed amounts? does the same thing as *0.8*0.8 orrrr return a computed variable that derives from the previously defined coordinate positioning system definitions e.g. northwest
    // linear increment? vs fraction? math-e-mat-ics. 0.8*0.8 to bring closer to centre. but 0.1*0.8...
    // linear increment simplest is best to start with. 0.1 + 0.05 and 0.8 - 0.05
    // standard probably only makes sense for silly duckman four corners attack initial spawn system... sooo don't think too hard.
    // static func closer()
    static func closerToMid(spawnPosition: CGPoint) -> CGPoint {
        <#code#>
    }
    
    static func furtherFromMid(spawnPosition: CGPoint) -> CGPoint {
        <#code#>
    }
    


}
