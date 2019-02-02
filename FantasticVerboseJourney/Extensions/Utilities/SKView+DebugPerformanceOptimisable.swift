//
//  SKView+DebugPerformanceOptimisable.swift
//  FantasticVerboseJourney
//
//  Created by SLim on 30/12/18.
//  Copyright © 2019 CousinMango. All rights reserved.
//

import SpriteKit.SKView

extension SKView: DebugPerformanceOptimisable {
    /// Set performance optimisations for SKViews.
    func setPerformanceOptimisation(enable toggle: Bool = true) {
        // Performance optimisation avoid calculating superfluous order.
        self.ignoresSiblingOrder = toggle
    }
    /// Enable display of stats for debugging SKViews.
    func setShowDebug(enable toggle: Bool = true) {
        // Debug stats
        self.showsFPS = toggle
        self.showsNodeCount = toggle
        self.showsFields = toggle
        self.showsDrawCount = toggle
        self.showsQuadCount = toggle
    }
}
