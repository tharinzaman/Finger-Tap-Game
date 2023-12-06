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
    
    var gameHandler = GameHandler()
    let coreDataHandler = CoreDataHandler()
    
    let context = (
        UIApplication.shared.delegate as! AppDelegate
    ).persistentContainer.viewContext
    var timer = Timer()
    
    var resetLabelsAndButtons: () -> Void = {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        disableButton(
            tapButton
        )
        resetLabels()
    }
    
    @IBAction func startGame(
        _ sender: UIButton
    ) {
        timer = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(
                timerDecremented
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
        if gameHandler.areTapsRemaining() {
            tapsRemainingLabel.text = String(
                gameHandler.tapsRemaining
            )
        }
        // If there are no taps remaining, end the game
        else {
            gameEnded(decremeneted: .tap)
        }
    }
    
    @objc func timerDecremented() {
        // If the timer hasn't ended yet then update the label
        if !gameHandler.hasTimerEnded() {
            timerLabel.text = String(
                gameHandler.secondsRemaining
            )
        }
        // If the timer has ended, end the game
        else {
            gameEnded(decremeneted: .timer)
        }
    }
    
    private func gameEnded(decremeneted: DecrementEnum) {
        
        var gameResult: GameResultEnum
        if decremeneted == .tap {
            gameResult = gameHandler.tapsFinishedCheckIfGameWon()
        } else {
            gameResult = gameHandler.timerEndedCheckIfGameWon()
        }
    
        gameHandler.gameEnded(
            timer: self.timer,
            gameResult: gameResult,
            resetLabelsAndButtons: {
                [self] in
                resetLabels()
                disableButton(
                    tapButton
                )
                enableButton(
                    startButton
                )
                
            },
            displayAlert: {
                gameResult in
                self.createAlert(
                    gameResult: gameResult
                )
            },
            addToCoreData: {
                date,
                timeTaken,
                tapsCompleted,
                gameResult in
                coreDataHandler.addFingerTapGameAttempt(context: context, date: date, timeTaken: timeTaken, tapsCompleted: tapsCompleted, gameResult: gameResult)
            }
        )
    }
    
}

// MARK: - This extension contains functions that are used for the UI
extension GameScreenViewController {
    
    private func resetLabels() {
        timerLabel.text = String(
            Constants.TIMER_DURATION
        )
        tapsRemainingLabel.text = String(
            Constants.TAPS_AMOUNT
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
    
    private func createAlert(
        gameResult: GameResultEnum
    ) {
        let strings = createAlertStrings(
            gameResult: gameResult
        )
        let alert = UIAlertController(
            title: strings[.title],
            message: strings[.message],
            preferredStyle: .alert
        )
        alert.addAction(
            UIAlertAction(title: NSLocalizedString(
                strings[.action]!,
                comment: "Default action"
            ),
                          style: .default,
                          handler: {
                              _ in
                              NSLog(
                                "The \"OK\" alert occured."
                              )
                          })
        )
        self.present(
            alert,
            animated: true,
            completion: nil
        )
    }
    
    private func createAlertStrings(
        gameResult: GameResultEnum
    ) -> Dictionary<
        AlertKeysEnum,
        String
    > {
        if gameResult == .won {
            return [
                .title: Strings.WON_TITLE,
                .message: Strings.WON_MESSAGE,
                .action: Strings.WON_ACTION
            ]
        } else {
            return [
                .title: Strings.LOST_TITLE,
                .message: Strings.LOST_MESSAGE,
                .action: Strings.LOST_ACTION
            ]
        }
    }
    
}
