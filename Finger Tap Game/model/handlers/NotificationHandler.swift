//
//  NotificationHandler.swift
//  Finger Tap Game
//
//  Created by Tharin Zaman on 06/12/2023.
//

import Foundation
import UserNotifications

struct NotificationHandler {
    
    let notificationCenter = UNUserNotificationCenter.current()

    func checkForPermissions() {
        // Go and see if we have notification permission using the getNotificationSrttings() method.
        notificationCenter.getNotificationSettings { settings in
            /* The settings.authorizationStatus tells us the state of the notification settings, switch through all possible cases and
             do what is needed for them */
            switch settings.authorizationStatus {
                /* If the notification permission setting is undetermined then try to request authorization, if the user allows it and there is no error, then try to dispatch the notification
                 */
            case .notDetermined:
                notificationCenter.requestAuthorization(options: [.alert, .sound]) { didAllow, error in
                    guard error == nil else {
                        return
                    }
                    if didAllow {
                        self.dispatchNotifications()
                    }
                }
            case .authorized:
                self.dispatchNotifications()
            case .denied:
                return
            case .provisional:
                return
            case .ephemeral:
                return
            @unknown default:
                return
            }
        }
    }
    
    private func dispatchNotifications() {
        let identifier = "my-morning-notification"
        let title = "Time to test your fingers!"
        let body = "Don't forget to play!"
        let hour = 16
        let minute = 30
        let isDaily = true
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        
        let calendar = Calendar.current
        var dateComponents = DateComponents(calendar: calendar, timeZone: TimeZone.current)
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: isDaily)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
        notificationCenter.add(request)
    }
}
