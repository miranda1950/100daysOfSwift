//
//  Note.swift
//  Consolidation19-21
//
//  Created by COBE on 29.08.2022..
//

import UIKit

class Note: NSObject, Codable {

    var title: String
    var body: String
    
    init(title: String, body: String) {
        self.title = title
        self.body = body
    }
    
}
