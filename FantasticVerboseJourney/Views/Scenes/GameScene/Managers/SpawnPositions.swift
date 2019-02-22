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

    // 0 to 1 assumption 0,0 anchor point (but scene probs uses 0.5, 0.5
    // could also back convert this to proper scale. renormalise the scale.
    static let northWestern = CGPoint(x: 0.1, y: 0.8)
    static let northEastern = CGPoint(x: 0.8, y: 0.8)
    static let southWestern = CGPoint(x: 0.1, y: 0.1)
    static let southEastern = CGPoint(x: 0.8, y: 0.1)

}
