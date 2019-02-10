//
//  PhysicsCategory.swift
//  FantasticVerboseJourney
//
//  Created by SLim on 10/2/19.
//  Copyright © 2019 CousinMango. All rights reserved.
//

// 32-bit numbers for bit operations e.g. AND for physics collision detection
// permissions
struct PhysicsCategory {
    // swiftlint:disable colon
    static let none         : UInt32 = 0
    //static let all        : UInt32 = UInt32.max
    static let chicken      : UInt32 = 0b1          // 1
    static let fryingPan    : UInt32 = 0b10         // 2
    static let fireball     : UInt32 = 0b11         // 3
    static let timeHourglass: UInt32 = 0b100        // 4
}
