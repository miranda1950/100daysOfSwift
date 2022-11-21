//
//  Utils.swift
//  Milestone5
//
//  Created by COBE on 25.08.2022..
//

import Foundation

class Utils {
    static func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
        
    }
    
    static func getImageUrl(for imageName: String) -> URL {
        return getDocumentsDirectory().appendingPathComponent(imageName)
    }
}
