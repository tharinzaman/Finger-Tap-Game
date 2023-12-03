//  GameScreenViewController.swift
//  Finger Tap Game
//
//  Created by Tharin Zaman on 21/11/2023.
//

import UIKit

class GameScreenViewController: UIViewController {
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var tapsRemainingLabel: UILabel!
    @IBOutlet weak var tapButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    
    var model = GameModel()
    var timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
        disableButton(
            tapButton
        )
    }
    
    @IBAction func gameStarted(
        _ sender: UIButton
    ) {
        timer = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(
                updateTimerLabel
            ),
            userInfo: nil,
            repeats: true
        )
        enableButton(
            tapButton
        )
        disableButton(
            sender
        )
    }
    
    @IBAction private func tapPressed(
        _ sender: UIButton
    ) {
        // If there are still taps remaining then update the label
        if model.areTapsRemaining() {
            tapsRemainingLabel.text = String(
                model.tapsRemaining
            )
        }
        // If there are no taps remaining, end the game
        else {
            endGame(
                gameResult: model.tapsFinishedCheckIfGameWon()
            )
        }
    }
    
    @objc func updateTimerLabel() {
        // If the timer hasn't ended yet then update the label
        if !model.hasTimerEnded() {
            timerLabel.text = String(
                model.secondsRemaining
            )
        }
        // If the timer has ended, end the game
        else {
            endGame(
                gameResult: model.timerEndedCheckIfGameWon()
            )
        }
    }
    
    private func endGame(
        gameResult: GameResultEnum
    ) {
        model.gameEnded(
            timer: self.timer,
            gameResult: gameResult
        )
            disableButton(
                tapButton
            )
            enableButton(
                startButton
            )
            resetLabels()
    }
    
    private func resetLabels() {
        timerLabel.text = String(
            model.secondsRemaining
        )
        tapsRemainingLabel.text = String(
            model.tapsRemaining
        )
    }
    
    private func enableButton(
        _ button: UIButton
    ) {
        button.backgroundColor = .white
        button.isEnabled = true
    }
    
    private func disableButton(
        _ button: UIButton
    ) {
        button.backgroundColor = .gray
        button.isEnabled = false
    }
    
    private func roundUIElementCorner() {
        // Implement later when focus is on UI
    }

}
