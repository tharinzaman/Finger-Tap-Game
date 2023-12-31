//
//  ScoreDefaults.swift
//  Finger Tap Game
//
//  Created by Tharin Zaman on 04/12/2023.
//

import Foundation

protocol ScoreDefaults {
    func getHighestScore() -> Int
    func setNewHighestScore(_ newScore: Int)
}
