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
    var gameTimeLeftSeconds: Int // KVO isn't nice in swift.

    private var gameTimer: Timer!

    init(delegate: TimeManagerDelegate, initialTimeSeconds: Int) {
        self.delegate = delegate
        self.gameTimeLeftSeconds = initialTimeSeconds

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
            block: {
                (timer) in
                print("TimeManager:: setupTimer() block closure")
                //                `self`.delegate.timerTriggerPerSecond(currentTimeLeft: self.gameTimeLeft)
                `self`.trigger(timer: timer, intervalSeconds: oneSecondInterval)
                //            [weak self] self.trigger(timer: timer)
            }
        )
    }
    mutating func trigger(timer: Timer, intervalSeconds: TimeInterval) {
        let intervalInSeconds = -Int(intervalSeconds) // ? Swift 4 Int(clamped:)

        let calculatedTimeLeft = self.checkCalcTimeLeftZero(
            secondsLeftPreCalc: self.gameTimeLeftSeconds,
            secondsToIncrement: intervalInSeconds
        ) // check here or in nested function?
        let noTimeLeft = (self.gameTimeLeftSeconds <= 0)

        if (noTimeLeft) {
            self.finishTimer()
        } else {
            self.increment(step: intervalInSeconds)

            self.delegate.timerTriggerPerSecond(currentTimeLeft: self.gameTimeLeftSeconds)
        }
        //        print("lol", timer)
    }

    // Could also enforce max limit.
    // Return the calculated with the floor limit. Increment for +ve -ve
    func checkCalcTimeLeftZero(secondsLeftPreCalc: Int, secondsToIncrement: Int) -> Int {
        // Immutability as much as possible?

        let proposedIncrementedCalc = secondsLeftPreCalc + secondsToIncrement

        // Lower limit zero enforced for timer to avoid glitches.
        let timeLeft = proposedIncrementedCalc <= 0 ? 0 : proposedIncrementedCalc

        return timeLeft
    }


    mutating func increment(step: Int) {
        self.gameTimeLeftSeconds += step

    }

    // Cleanup and trigger delegate for the last time.
    func finishTimer() {
        self.delegate.timerFinished()
        // Cleanup
        self.gameTimer.invalidate()

    }
}
