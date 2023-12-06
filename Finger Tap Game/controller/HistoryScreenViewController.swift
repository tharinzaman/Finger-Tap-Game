//
//  HistoryScreenViewController.swift
//  Finger Tap Game
//
//  Created by Tharin Zaman on 21/11/2023.
//

import UIKit

class HistoryScreenViewController: UIViewController {
    
    @IBOutlet weak var highestScoreLabel: UILabel!
    @IBOutlet weak var gameAttemptsTableView: UITableView!
    
    let coreDataHandler = CoreDataHandler()
    let gameHandler = GameHandler()
    
    let context = (
        UIApplication.shared.delegate as! AppDelegate
    ).persistentContainer.viewContext
    
    var attempts: [FingerTapGameAttemptEntity]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameAttemptsTableView.dataSource = self
        gameAttemptsTableView.delegate = self
        attempts = coreDataHandler.fetchFingerTapGameAttempts(
            context: context
        ) {
            DispatchQueue.main.async {
                self.gameAttemptsTableView.reloadData()
            }
        }
        highestScoreLabel.text = String(
            gameHandler.fetchHighstScore()
        )
    }
    
}

extension HistoryScreenViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return self.attempts?.count ?? 0
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = gameAttemptsTableView.dequeueReusableCell(
            withIdentifier: "GameAttemptCell",
            for: indexPath
        ) as! GameAttemptCell
        let attempt = self.attempts?[indexPath.row]
        guard self.attempts?[indexPath.row] != nil else {
            return cell
        }
        cell.dateTimeLabel.text = attempt!.date.description
        cell.gameResultLabel.text = attempt!.gameResultAsString
        cell.tapsCompletedLabel.text = String(
            attempt!.tapsCompleted
        )
        cell.timeTakenLabel.text = String(
            attempt!.timeTaken
        )
        return cell
    }

}
