//
//  GameModel.swift
//  Finger Tap Game
//
//  Created by Tharin Zaman on 30/11/2023.
//

import Foundation
import UIKit

struct GameModel {
    
    var secondsRemaining = 60
    var tapsRemaining = 100
    
    mutating func gameEnded(
        timer: Timer,
        gameResult: GameResultEnum
    ) {
        timer.invalidate()
        resetVariables()
        switch gameResult {
        case .won:
            print(
                "Won"
            )
        case .lost:
            print(
                "Lost"
            )
        }
    }
    
    private mutating func resetVariables() {
        secondsRemaining = 60
        tapsRemaining = 100
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
    
    private mutating func decrementTimerByOneSecond() {
        secondsRemaining -= 1
    }
    
    private mutating func decrementTapsByOne() {
        tapsRemaining -= 1
    }
    
}
