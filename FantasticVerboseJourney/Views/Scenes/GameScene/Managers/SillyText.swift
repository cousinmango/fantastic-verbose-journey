//
//  SillyText.swift
//  FantasticVerboseJourney
//
//  Created by SLim on 18/2/19.
//  Copyright © 2019 CousinMango. All rights reserved.
//

import Foundation
import struct SpriteKit.CGFloat

struct SillyText {
    static let fontName = "DIN Alternate"

    // rip enum .rawValue is an extra step compared to struct static let
    enum FontSize: Int {
        case large = 80 // have some sort of standard
        case medium = 40
        case normal = 20

    }
}

extension SillyText.FontSize {
    var cgFloat: CGFloat {
        switch self {
        case .large:
            return CGFloat(self.rawValue)
        case .medium:
            return CGFloat(self.rawValue)
        default:
            return CGFloat(SillyText.FontSize.normal.rawValue)
        }
    }
}
