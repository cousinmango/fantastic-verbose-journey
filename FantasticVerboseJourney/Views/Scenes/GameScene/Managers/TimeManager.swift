//
//  TimeManager.swift
//  FantasticVerboseJourney
//
//  Created by SLim on 10/2/19.
//  Copyright © 2019 CousinMango. All rights reserved.
//

import Foundation

protocol TimeManagerDelegate {
    func timerTriggerPerSecond()

    func timerFinished()
}

struct TimeManager {
    var delegate: TimeManagerDelegate
    var gameTimeLeft: Int // KVO isn't nice in swift.

    private var gameTimer: Timer
}

extension TimeManager {

    mutating func setupTimer() {
        let oneSecondInterval: TimeInterval = 1
        self.gameTimer = Timer.scheduledTimer(
            withTimeInterval: oneSecondInterval,
            repeats: true,
            block: { (timer) in
//            [weak self] self.trigger(timer: timer)
        })
    }
    func trigger(timer: Timer) {
        self.delegate.timerTriggerPerSecond()
        print("lol", timer)
    }
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
