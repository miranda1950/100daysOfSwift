//
//  Data.swift
//  Milestone5
//
//  Created by COBE on 22.08.2022..
//

import UIKit

class Data2: NSObject, Codable {

    
    var imageName: String
    var imageCaption: String
    
    init(imageName: String, imageCaption: String) {
        
        self.imageName = imageName
        self.imageCaption = imageCaption
    }
    
}
