//
//  CGSize+VectorCalculatable.swift
//  FantasticVerboseJourney
//
//  Created by SLim on 21/2/19.
//  Copyright © 2019 CousinMango. All rights reserved.
//

import Foundation

import struct CoreGraphics.CGGeometry.CGSize
import struct CoreGraphics.CGGeometry.CGFloat
import struct CoreGraphics.CGGeometry.CGPoint

/// Only needed the multiply operator.... can remove conformation
/// Too many responsibilities in protocol..
extension CGSize: VectorCalculatable {
    static func +(left: CGSize, right: CGSize) -> CGSize {
        return CGSize(width: left.width + right.width, height:  left.height + right.height)
    }
    static func -(left: CGSize, right: CGSize) -> CGSize {
        return CGSize(width: left.width - right.width, height:  left.height - right.height)
    }
    static func +-(left: CGSize, right: CGSize) -> CGSize {
        return CGSize(width: left.width + right.width, height:  left.height - right.height)
    }
    static func *(point: CGSize, scalar: CGFloat) -> CGSize {
        // multiplied proportion.
        return CGSize(
            width: point.width * scalar,
            height: point.height * scalar
        )
    }
    static func /(point: CGSize, scalar: CGFloat) -> CGSize {
        return CGSize(width: point.width / scalar, height:  point.height / scalar)
    }

    #if !(arch(x86_64) || arch(arm64))
    func sqrt(decimalNumber: CGFloat) -> CGFloat {
        return CGFloat(sqrtf(Float(decimalNumber)))
    }
    #endif

    func length() -> CGFloat {
        return sqrt(width * width + height * height)
    }

    // Random protocol conformance useless.
    // Normalise 1-unit vector with magnitude.  / length = 1
    func normalized() -> CGPoint {
        return CGPoint(x: self.width, y: self.height) / length()
    }

}
