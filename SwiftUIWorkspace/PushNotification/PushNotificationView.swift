//
//  PushNotificationView.swift
//  SwiftUIWorkspace
//
//  Created by Siran Li on 12/9/24.
//

import SwiftUI
import UserNotifications
import CoreLocation

class NotificationManager {
    static let instance = NotificationManager()
    
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { (bool, error) in
            if let error = error {
                print("error: \(error)")
            } else {
                print("success")
            }
        }
    }
    
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "push notification"
        content.subtitle = "try push notification"
        content.sound = .default
        content.badge = 1
        
        let triggerTime = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
        
        var dateComponents = DateComponents()
        dateComponents.hour = 19
        dateComponents.minute = 32
        dateComponents.day = 3
        let triggerDate = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        /*
         info.plist needs following:
         <key>NSLocationWhenInUseUsageDescription</key>
         <string>This app needs access to your location to trigger notifications</string>
         */
        let locationTrigger = UNLocationNotificationTrigger(
            region: CLCircularRegion(
                center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
                radius: 100,
                identifier: "San Francisco"
            ),
            repeats: true
        )
        
        let requestTime = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: triggerTime
        )
        
//        let requestDate = UNNotificationRequest(
//            identifier: UUID().uuidString,
//            content: content,
//            trigger: triggerDate
//        )
//        
//        let requestLocation = UNNotificationRequest(
//            identifier: UUID().uuidString,
//            content: content,
//            trigger: locationTrigger
//        )
        
        
        // two cannot be used at the same time becasue they use the same content, if try to add both of them, need two content
        UNUserNotificationCenter.current().add(requestTime)
//        UNUserNotificationCenter.current().add(requestDate)
//        UNUserNotificationCenter.current().add(requestLocation)
    }
    
    func resetBadgeCount() {
        let center = UNUserNotificationCenter.current()
        center.setBadgeCount(0) { error in
            if let error = error {
                print("Error resetting badge count: \(error.localizedDescription)")
            }
        }
    }
}

struct PushNotificationView: View {
    @Environment(\.scenePhase) var scenePhase
    
    var body: some View {
        VStack(spacing: 40) {
            Button("Request Permission") {
                NotificationManager.instance.requestAuthorization()
            }
            Button("Schedule Notification") {
                NotificationManager.instance.scheduleNotification()
            }
        }
        .onChange(of: scenePhase) {
            if scenePhase == .active {
                NotificationManager.instance.resetBadgeCount()
            }
        }
    }
}

#Preview {
    PushNotificationView()
}
