//
//  capImage.swift
//  Project10-12 Milestone
//
//  Created by Roberts Kursitis on 26/04/2022.
//

import UIKit

class capImage: NSObject, Codable {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
