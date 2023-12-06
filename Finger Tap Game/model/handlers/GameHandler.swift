//
//  GameModel.swift
//  Finger Tap Game
//
//  Created by Tharin Zaman on 30/11/2023.
//

import Foundation
import UIKit

struct GameHandler {

    var secondsRemaining = Constants.TIMER_DURATION
    var tapsRemaining = Constants.TAPS_AMOUNT
    
    let scoreDefaults: ScoreDefaults = ScoreDefaultsImpl()
    
    mutating func gameEnded(
        timer: Timer,
        gameResult: GameResultEnum,
        resetLabelsAndButtons: () -> Void,
        displayAlert: (
            _ gameResult: GameResultEnum
        ) -> Void,
        addToCoreData: (
            _ date: Date,
            _ timeTaken: Int64,
            _ tapsCompleted: Int64,
            _ gameResult: GameResultEnum
        ) -> Void
    ) {
        timer.invalidate()
        if gameResult == .won {
            checkAndSetNewHighestScore()
        }
        displayAlert(
            gameResult
        )
        addToCoreData(
            Date.now,
            Int64(calculateTimeTaken()),
            Int64(calculateTapsCompleted()),
            gameResult
        )
        resetVariables()
        resetLabelsAndButtons()
    }
    
    mutating func hasTimerEnded() -> Bool {
        if secondsRemaining > 0 {
            decrementTimerByOneSecond()
            return false
        } else {
            return true
        }
    }
    
    mutating func areTapsRemaining() -> Bool {
        if tapsRemaining > 0 {
            decrementTapsByOne()
            return true
        } else {
            return false
        }
    }
    
    func timerEndedCheckIfGameWon() -> GameResultEnum {
        if tapsRemaining > 1 {
            return .lost
        } else {
            return .won
        }
    }
    
    func tapsFinishedCheckIfGameWon() -> GameResultEnum {
        if secondsRemaining > 0 {
            return .won
        } else {
            return .lost
        }
    }
    
    func fetchHighstScore() -> Int {
        return scoreDefaults.getHighestScore()
    }
    
}

// MARK: - This code is privately used for calculation

extension GameHandler {
    private func calculateTimeTaken() -> Int {
        return Constants.TIMER_DURATION - secondsRemaining
    }
    
    private func calculateTapsCompleted() -> Int {
        return Constants.TAPS_AMOUNT - tapsRemaining
    }
}

//MARK: - This extension is for miscallenous internal/private functions
extension GameHandler {
    
    private mutating func decrementTimerByOneSecond() {
        secondsRemaining -= 1
    }
    
    private mutating func decrementTapsByOne() {
        tapsRemaining -= 1
    }
    
    private mutating func resetVariables() {
        secondsRemaining = Constants.TIMER_DURATION
        tapsRemaining = Constants.TAPS_AMOUNT
    }
    
    private func checkAndSetNewHighestScore() {
        let timeTaken = calculateTimeTaken()
        let highestScore = scoreDefaults.getHighestScore()
        // If highest score is 0, that means this is the first time winning/playing, set the timeTaken
        if highestScore == 0 {
            scoreDefaults.setNewHighestScore(
                timeTaken
            )
        } else {
            if timeTaken < highestScore {
                scoreDefaults.setNewHighestScore(
                    timeTaken
                )
            }
        }
    }
    
}
