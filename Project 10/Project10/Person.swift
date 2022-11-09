//
//  Person.swift
//  Project10
//
//  Created by Roberts Kursitis on 18/04/2022.
//
//

import UIKit

class Person: NSObject {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
