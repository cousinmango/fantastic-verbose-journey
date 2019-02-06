//  VectorCalculatable.swift
//  FantasticVerboseJourney
//
//  Created by SLim on 2018-12-30.
//  Copyright © 2019 CousinMango. All rights reserved.
//

import Foundation
import struct CoreGraphics.CGGeometry.CGPoint
import struct CoreGraphics.CGGeometry.CGFloat

infix operator +-: AdditionPrecedence
infix operator ☺️: AdditionPrecedence // lol

protocol VectorCalculatable {

    static func + (left: Self, right: Self) -> Self
    static func +- (left: Self, right: Self) -> Self
    static func -(left: Self, right: Self) -> Self
    //    static func *(left: Self, right: Self) -> Self
    //    static func /(left: Self, right: Self) -> Self
    static func *(point: Self, scalar: CGFloat) -> Self
    static func /(point: Self, scalar: CGFloat) -> Self

    func length() -> CGFloat

    func normalized() -> CGPoint

}
