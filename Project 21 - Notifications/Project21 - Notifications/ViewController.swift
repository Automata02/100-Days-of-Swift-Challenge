//
//  ViewController.swift
//  Project21 - Notifications
//
//  Created by Roberts Kursitis on 09/06/2022.
//
import UserNotifications
import UIKit

class ViewController: UIViewController, UNUserNotificationCenterDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "register", style: .plain, target: self, action: #selector(registerLocal))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "schedule", style: .plain, target: self, action: #selector(initialSchedule))
    }
    @objc func registerLocal() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) {
            granted, error in
            if granted {
                print("Yay!")
            } else {
                print("D'oh!")
            }
        }
    }
    @objc func initialSchedule() {
        scheduleLocal(delaySeconds: 5)
    }
    func scheduleLocal(delaySeconds: TimeInterval) {
        registerCategories()
        
        let center = UNUserNotificationCenter.current()
        
        //bellow is the entire contents of the notification
        let content = UNMutableNotificationContent()
        content.title = "Late wakeup call"
        content.body = "The early bird catches the worm, but the second mouse gets the cheese."
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData": "fizzbuzz"]
        content.sound = .default
        
//        var dateComponents = DateComponents()
//        dateComponents.hour = 10
//        dateComponents.minute = 30
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }
    
    func registerCategories() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        
        let show = UNNotificationAction(identifier: "Show", title: "Tell me more...", options: .foreground)
        // .foreground launches app
        let dismiss = UNNotificationAction(identifier: "Remove", title: "Hide this...", options: .destructive)
        let remind = UNNotificationAction(identifier: "Later", title: "Remind me later", options: [])
        
        let category = UNNotificationCategory(identifier: "alarm", actions: [show, remind, dismiss], intentIdentifiers: [], options: [])
        center.setNotificationCategories([category])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        if let customData = userInfo["customData"] as? String {
            print("Custom data received: \(customData)")
            
            switch response.actionIdentifier {
            case UNNotificationDefaultActionIdentifier:
                //user swiped to unlock
                print("Default identifier")
            case "Show":
                print("Show more information...")
            case "Dismiss":
                print("user dismissed the notification 😭")
            case "Later":
                scheduleLocal(delaySeconds: 3600*24)
                print("Postponed by 24 hours.")
            default:
                break
            }
        }
        
        completionHandler()
    }

}

