//
//  ViewController.swift
//  Project7


import UIKit

class ViewController: UITableViewController {
    var petitions = [Petition]()
    var filteredPets = [Petition]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Petitions🔫🎉"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(credits))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(search))
        
        
        let urlString: String
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
    
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                return
            }
            
        }
        showError()
    }
    
    func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        //no handler - dismissed the alert by default
        present(ac, animated: true)
    }
    //error method that displays a cancellable alert
    
    
    @objc func credits() {
        let ac = UIAlertController(title: "Data collected from We The People API of the Whitehouse", message: nil, preferredStyle: .actionSheet)
        let ok = UIAlertAction(title: "👌🏾", style: .default)
        ac.addAction(ok)
        present(ac, animated: true)
    }
    
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            filteredPets = jsonPetitions.results
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPets.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = filteredPets[indexPath.row]
        
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = filteredPets[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func search() {
        let ac = UIAlertController(title: "Enter a keyword:", message: nil, preferredStyle: .alert)
        ac.addTextField()
        //search action passes the textFields input to the submit function
        let filter = UIAlertAction(title: "Search", style: .default) {
            [weak self, weak ac] action in
            guard let searchTerm = ac?.textFields?[0].text else { return }
            self?.submit(searchTerm)
        }
        ac.addAction(filter)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        ac.addAction(cancel)
        present(ac, animated: true)
    }
    
    func submit(_ searchTerm: String) {
            // remove all entries from the filteredPets array
            filteredPets.removeAll(keepingCapacity: true)
            let term = searchTerm.lowercased()
            // checks for the term inside the title and body of all petitions and if there is no search term reverts filteredPets to all petitions
            if term == "" {
                filteredPets = petitions
                title = "EVERYTHING✌️💀"
            } else {
                for petition in petitions {
                    if petition.title.lowercased().contains(term) || petition.body.lowercased().contains(term) {
                        filteredPets.append(petition)
                    }
                }
                title = "Results for 👉🏽\(term)👈🏽"
            }
            
            // Reloads tableView (need this real bad!)
            tableView.reloadData()
            
        }
}

