//
//  ViewController.swift
//  Project18
//
//  Created by Roberts Kursitis on 21/05/2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print(1, 2, 3, 4, 5, separator: "-")
        print("Some message", terminator: "")
        assert(1 == 1, "Math failure")
        
        for i in 1...100 {
            print("Got number \(i)")
        }
    }
}

