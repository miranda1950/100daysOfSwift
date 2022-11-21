//
//  ViewController.swift
//  Consolidation13-15
//
//  Created by COBE on 24.08.2022..
//

import UIKit

class ViewController: UITableViewController {
    
    var countries = [Country] ()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                
                parse(json: data)
            }
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNew))
        self.title = "Countries"
    }

    func parse (json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonCountries = try? decoder.decode(Countries.self, from: json) {
            countries = jsonCountries.results
            
            
            tableView.reloadData()
        }
            
    }
    @objc func addNew() {
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let countryName = countries[indexPath.row]
        cell.textLabel?.text = countryName.title
        cell.textLabel?.numberOfLines = 0
        cell.accessoryType = .disclosureIndicator
       // cell.detailTextLabel?.text = countryName.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = countries[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

