//
//  FingerTapGameAttemptEntity+CoreDataProperties.swift
//  Finger Tap Game
//
//  Created by Tharin Zaman on 05/12/2023.
//
//

import Foundation
import CoreData


extension FingerTapGameAttemptEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FingerTapGameAttemptEntity> {
        return NSFetchRequest<FingerTapGameAttemptEntity>(
            entityName: "FingerTapGameAttemptEntity"
        )
    }
    
    @NSManaged public var date: Date
    @NSManaged public var timeTaken: Int64
    @NSManaged public var tapsCompleted: Int64
    
    @NSManaged public var gameResultAsString: String
    var gameResult: GameResultEnum {
        get {
            return GameResultEnum(
                rawValue: self.gameResultAsString
            ) ?? .lost
        }
        set {
            self.gameResultAsString = newValue.rawValue
        }
    }
}

extension FingerTapGameAttemptEntity : Identifiable {
}
