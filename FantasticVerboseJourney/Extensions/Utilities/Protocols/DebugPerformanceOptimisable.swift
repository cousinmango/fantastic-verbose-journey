//  VectorCalculatable.swift
//  FantasticVerboseJourney
//
//  Created by SLim on 2018-12-30.
//  Copyright © 2019 CousinMango. All rights reserved.
//

/// Convenience setup for debugging or performance toggles
protocol DebugPerformanceOptimisable {
    func setPerformanceOptimisation(enable toggle: Bool)
    func setShowDebug(enable toggle: Bool)
}
