//
//  Note.swift
//  Consolidation19-21Miran
//
//  Created by COBE on 01.09.2022..
//

import UIKit

class Note: NSObject, Codable {

    var title: String
    var body: String
    
    init(title: String, body: String) {
        self.title = title
        self.body = body
    }
    
    static func save(notepad: [Note]) {
        
        let encoder = JSONEncoder()
        if let saveData = try? encoder.encode(notepad) {
            let defaults = UserDefaults.standard
            defaults.set(saveData,forKey: "notepad")
            
        }
    }
}
