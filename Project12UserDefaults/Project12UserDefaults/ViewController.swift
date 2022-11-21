//
//  ViewController.swift
//  Project12UserDefaults
//
//  Created by COBE on 18.08.2022..
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let defaults = UserDefaults.standard
        
        defaults.set(25, forKey: "Age")
        defaults.set(true, forKey: "UserFaceID")
        defaults.set(CGFloat.pi, forKey: "Pi")
        
        defaults.set("Paul Hudson", forKey: "Name")
        defaults.set(Date(), forKey: "LastRun")
        
        let array = ["Hello", "World"]
        defaults.set(array, forKey: "SavedArray")
        
        let dict = ["Name": "Paul", "Country": "UK"]
        defaults.set(dict, forKey: "SavedDictionary")
        
        
        let savedInteger = defaults.integer(forKey: "Age")
        
        let savedBoolean = defaults.bool(forKey: "UserFaceID")
        
        let savedArray = defaults.object(forKey: "SavedArray") as? [String] ?? [String] ()
        
        let savedDictionary = defaults.object(forKey: "SavedDictionary") as? [String: String] ?? [String: String] ()
        
    }


}

