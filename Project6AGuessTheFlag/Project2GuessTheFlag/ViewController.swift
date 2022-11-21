//
//  ViewController.swift
//  Project2GuessTheFlag
//
//  Created by COBE on 06.08.2022..
//
import UserNotifications
import UIKit

class ViewController: UIViewController, UNUserNotificationCenterDelegate {

    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var counter = 0
    var highestScore = -10
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries += ["estonia", "france", "germany", "ireland", "italy","monaco", "nigeria","poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor(red: 1.0, green: 0.6, blue: 0.2, alpha: 1.0).cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor

        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Score", style: .plain, target: self, action: #selector(showScore))
        
        let userDefaults = UserDefaults.standard
        highestScore = userDefaults.object(forKey: "HighestScore") as? Int ?? -10
        
        manageNotifications()
        askQuestion(/*action: nil*/)
        
    }
    
    func manageNotifications() {
        let centar = UNUserNotificationCenter.current()
        
        centar.getNotificationSettings {
            [weak self] (settings) in
            // ako korisnik nije izabrao da prima notifikacije
            if settings.authorizationStatus == .notDetermined {
                let ac = UIAlertController(title: "Daily reminder", message: "Allow notifications", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Next", style:
                        .default) { _ in
                            self?.requestNotificationsAuthorization()
                            
                        })
                self?.present(ac,animated: true)
                return
            }
            if settings.authorizationStatus == .authorized {
                self?.scheduleNotifications()
            }
        }
        
    }
    
    func requestNotificationsAuthorization() {
        
        let centar = UNUserNotificationCenter.current()
    
        centar.requestAuthorization(options: [.alert, .badge, .sound]) {
            
            [weak self] granted, error in
            if granted {
                self?.scheduleNotifications()
            }
            else {
                let ac = UIAlertController(title: "Notifications", message: "Your choice has been saved.\nShould you change your mind, head to \"Settings -> Project21-Challenge3 -> Notifications\" to update your preferences.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
                self?.present(ac, animated: true)
            }
        }
    
    }
    
    func scheduleNotifications() {
        let centar = UNUserNotificationCenter.current()
        
        centar.removeAllPendingNotificationRequests()
        let content  = UNMutableNotificationContent()
        
        content.title = "Daily reminder"
        content.body =  "Play the game"
        content.categoryIdentifier = "reminder"
        content.sound = .default
        
        let seconds: TimeInterval = 3600 * 24
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        centar.add(request)
        
    }
    

    func askQuestion(action: UIAlertAction! = nil) {
        
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        title = "\(countries[correctAnswer].uppercased()): \(score) "
        
        counter += 1
        
        
    }
    
    
    @objc func showScore() {
        
        var message = "Final score: \(score)"
        
        let ac = UIAlertController(title: "Current Score", message: "Your current score is: \(score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(ac, animated: true)
        
        var mustSave = false
        if score > highestScore {
            message += "New High Score: \(highestScore)"
            
            highestScore = score
            mustSave = true
        }

        
        if mustSave {
            performSelector(inBackground: #selector(saveHighestScore), with: nil)
        }
    }
    
    @objc func saveHighestScore() {
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(highestScore, forKey: "HighestScore")
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        
        
        var title: String
        var message: String
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
            
        message =  "Your score is \(score)"
        } else {
            title = "Wrong"
            score -= 1
            
            message = "You picked \(countries[sender.tag].uppercased()), your score is \(score)"
        }
        
        if counter == 10 {
            let ac = UIAlertController(title: "You finished the game", message: "Your final score is \(score)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Finish", style: .default, handler: askQuestion))
            ac.addAction(UIAlertAction(title: "Restart", style: .default,handler: askQuestion))
            score = 0
            correctAnswer = 0
            present(ac,animated: true)
            
            
        } else {
            
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present(ac,animated: true)
        }
       
        
        
    }
    
    
    
}

