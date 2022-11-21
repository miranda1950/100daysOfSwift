//
//  Storage.swift
//  Consolidation19-21
//
//  Created by COBE on 29.08.2022..
//

import Foundation

class Storage {
    
    static func loadPages() -> [Note] {
        let defaults = UserDefaults.standard
        
        var notepad = [Note] ()
        if let savedData = defaults.object(forKey: "notepad") as? Data {
            let decoder = JSONDecoder()
            
            notepad = (try? decoder.decode([Note].self, from: savedData)) ?? notepad
        }
        return notepad
    }
    
    
    static func save(notepad: [Note]) {
        
        let encoder = JSONEncoder()
        if let saveData = try? encoder.encode(notepad) {
            let defaults = UserDefaults.standard
            defaults.set(saveData,forKey: "notepad")
            
        }
    }
}
