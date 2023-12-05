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
        return NSFetchRequest<FingerTapGameAttemptEntity>(entityName: "FingerTapGameAttemptEntity")
    }

    @NSManaged public var date: Date?
    @NSManaged public var tapsCompleted: Int64
    @NSManaged public var gameResult: GameResultEnum?
    @NSManaged public var tapsPerSecond: Int64

}

extension FingerTapGameAttemptEntity : Identifiable {

}
