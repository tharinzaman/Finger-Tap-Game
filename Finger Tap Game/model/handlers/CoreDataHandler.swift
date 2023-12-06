//
//  CoreDataModel.swift
//  Finger Tap Game
//
//  Created by Tharin Zaman on 05/12/2023.
//

import Foundation
import CoreData

struct CoreDataHandler {
    
    func fetchFingerTapGameAttempts(
        context: NSManagedObjectContext
    ) -> [FingerTapGameAttemptEntity] {
        do {
            let request = FingerTapGameAttemptEntity.fetchRequest() as NSFetchRequest<FingerTapGameAttemptEntity>
            let sort = NSSortDescriptor(
                key: "date",
                ascending: true
            )
            request.sortDescriptors = [sort]
            return try context.fetch(
                request
            )
        } catch {
            return []
        }
    }
    
    func addFingerTapGameAttempt(
        context: NSManagedObjectContext,
        date: Date,
        timeTaken: Int64,
        tapsCompleted: Int64,
        gameResult: GameResultEnum
    ) {
        let gameAttempt = FingerTapGameAttemptEntity(context: context)
        gameAttempt.date = date
        gameAttempt.timeTaken = timeTaken
        gameAttempt.tapsCompleted = tapsCompleted
        gameAttempt.gameResult = gameResult
        do {
            try context.save()
            print(
                "Saved attempt"
            )
        } catch {
            print(
                "Unable to save attempt"
            )
        }
    }
}
