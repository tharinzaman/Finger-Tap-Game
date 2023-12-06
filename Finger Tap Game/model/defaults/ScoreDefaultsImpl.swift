//
//  ScoreDefaults.swift
//  Finger Tap Game
//
//  Created by Tharin Zaman on 04/12/2023.
//

import Foundation

struct ScoreDefaultsImpl: ScoreDefaults {

    let defaults = UserDefaults.standard
    
    func getHighestScore() -> Int {
        return defaults.integer(
            forKey: Constants.HIGHEST_SCORE_KEY
        )
    }
    
    func setNewHighestScore(_ newScore: Int) {
        defaults.set(
            newScore,
            forKey: Constants.HIGHEST_SCORE_KEY
        )
    }
    
}
