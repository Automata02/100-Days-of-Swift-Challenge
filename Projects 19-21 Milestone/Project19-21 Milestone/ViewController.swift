//
//  ViewController.swift
//  Project19-21 Milestone
//
//  Created by Roberts Kursitis on 13/06/2022.
//

import UIKit

class ViewController: UITableViewController {
    
    var notes = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        notes += ["ye"]
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Compose", style: .compose, target: self, action: #selector(composeNote))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Delete", style: .plain, target: self, action: #selector(deleteNote))
        
        title = "Notes but Worse"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    
    @objc func composeNote() {
        
    }
    @objc func deleteNote() {
        
    }


}

