//
//  Person.swift
//  Project10Face
//
//  Created by COBE on 16.08.2022..
//

import UIKit

class Person: NSObject, Codable {

    var name: String
    var image: String
    
    init(name: String, image: String) {
        
        self.name = name
        self.image = image
    }
    
    
}
