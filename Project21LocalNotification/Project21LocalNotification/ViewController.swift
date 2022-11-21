//
//  ViewController.swift
//  Project21LocalNotification
//
//  Created by COBE on 28.08.2022..
//

import UserNotifications
import UIKit

class ViewController: UIViewController, UNUserNotificationCenterDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Register", style: .plain, target: self, action: #selector(registerLocal))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Schedule", style: .plain, target: self, action: #selector(initialSchedule))
        
    }

    @objc func registerLocal() {
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound])  {
            granted, error  in
            if granted {
                print("Yay")
            } else {
                print("D'oh")
            }
        }
    }
    
    @objc func initialSchedule() {
        scheduleLocal(delaySeconds: 5)
    }
    
    func scheduleLocal(delaySeconds: TimeInterval) {
        
        registerCategories()
        
        let centar = UNUserNotificationCenter.current()
        centar.removeAllPendingNotificationRequests()
        
        
        let content = UNMutableNotificationContent()
        
        content.title = "Late wake up call"
        content.body = "The early bird catches the worm, but the second mouse  gets tge chease."
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData": "fizzbuzz"]
        content.sound = .default
        
     //   var dateComponents = DateComponents()
      //  dateComponents.hour = 10
       // dateComponents.minute = 30
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: delaySeconds,
                                                        repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        centar.add(request)
    }
    
    func registerCategories() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        
        //.foreground launch the app immidiately
        let show = UNNotificationAction(identifier: "show", title: "Tell me more", options: .foreground)
        
        let delay = UNNotificationAction(identifier: "delay", title: "Remind me later", options: .authenticationRequired)
        
        
        let cateogory = UNNotificationCategory(identifier: "alarm", actions: [show, delay], intentIdentifiers: [], options: [])
        
        
        center.setNotificationCategories([cateogory])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse,
    withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        
        if let customData = userInfo["customData"] as? String {
            print("Custom data received: \(customData)")
            
            switch response.actionIdentifier {
                
            case UNNotificationDefaultActionIdentifier:
                let ac = UIAlertController(title: "Swipe", message: "The user swiped", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
                present(ac,animated: true)
                
            case "show":
                let ac = UIAlertController(title: "Button", message: "The user tapped", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
                present(ac,animated: true)
            case "delay":
                scheduleLocal(delaySeconds: 10)
            default:
                break
            }
        }
         completionHandler()
    }
}

