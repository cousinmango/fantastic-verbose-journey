//
//  TimeManager.swift
//  FantasticVerboseJourney
//
//  Created by SLim on 10/2/19.
//  Copyright © 2019 CousinMango. All rights reserved.
//

import Foundation

protocol TimeManagerDelegate: class {
    func timerTriggerPerSecond(currentTimeLeft: Int)

    func timerFinished()
}

struct TimeManager {
    var delegate: TimeManagerDelegate // - FIXME: weak var. mem leak? retain cycles
    var gameTimeLeft: Int // KVO isn't nice in swift.

    private var gameTimer: Timer!

    init(delegate: TimeManagerDelegate, initialTime: Int) {
        self.delegate = delegate
        self.gameTimeLeft = initialTime

        self.setupTimer()
    }
}

extension TimeManager {

    mutating func setupTimer() {
        let oneSecondInterval: TimeInterval = 1
        var `self` = self   // wow what is this syntax.
        self.gameTimer = Timer.scheduledTimer(
            withTimeInterval: oneSecondInterval,
            repeats: true,
            block: { (timer) in
                print("TimeManager:: setupTimer() block closure")
                `self`.delegate.timerTriggerPerSecond(currentTimeLeft: 1)
//            [weak self] self.trigger(timer: timer)
        })
    }
    func trigger(timer: Timer) {
        self.checkTimeLeftZero()
        self.delegate.timerTriggerPerSecond(currentTimeLeft: self.gameTimeLeft)

        print("lol", timer)
    }

    // Could also enforce max limit.
    func checkTimeLeftZero() {
        let noTimeLeft = self.gameTimeLeft <= 0

        if noTimeLeft {
            self.delegate.timerFinished()

            // Cleanup
            self.gameTimer.invalidate()
        }

    }


    mutating func increment(step: Int) {
        self.gameTimeLeft += step

    }
}
