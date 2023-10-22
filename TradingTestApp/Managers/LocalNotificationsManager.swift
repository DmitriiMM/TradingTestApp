//
//  LocalNotificationsManager.swift
//  TradingTestApp
//
//  Created by Дмитрий Мартынов on 21.10.2023.
//

import UserNotifications

class LocalNotificationsManager {
    static var shared = LocalNotificationsManager()
    
    private let notificationCenter = UNUserNotificationCenter.current()
    
    func requestUserNotifications(completion: @escaping () -> Void) {
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { success, error in
            if success {
                print("Notifications are set successfully")
            } else if let error = error {
                print("Error on notification setup: \(error.localizedDescription)")
            }
            
            completion()
        }
    }
}
