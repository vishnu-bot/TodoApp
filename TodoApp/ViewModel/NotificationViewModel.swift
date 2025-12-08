//
//  NotificationViewModel.swift
//  TodoApp
//
//  Created by Vishnu on 07/12/25.
//

import Foundation
import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()

    // Permisson request for notification from user
    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if let error = error {
                print("❌ Notification permission error: \(error)")
            }
        }
    }
    
    // Scheduling a one - time notification for a specific date and time
    func scheduleNotification(title: String, body: String, date: Date) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        
        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    

    // Scheldule a daily recurring notification system
    func scheduleDailySummary(count: Int, hour: Int, minute: Int) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["daily_summary"])
        
        // Says what should be in the Notification
        let content = UNMutableNotificationContent()
        content.title = "Daily Task Summary"
        content.body = "You have \(count) tasks scheduled for today."
        content.sound = .default
        
        // Time - Hour and minutes of when the notification should occur, values are taken from function call
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: "daily_summary", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling daily notification: \(error)")
            } 
        }
    }
    
    
}
