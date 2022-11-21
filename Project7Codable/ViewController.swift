//
//  ViewController.swift
//  Project7Codable
//
//  Created by COBE on 11.08.2022..
//

import UIKit

class ViewController: UITableViewController {
    
    var petitions = [Petition] ()
    
    var filteredPetitions = [Petition] ()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
       /* let urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        */
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterPetitions))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(shareCredits))
        
   
        performSelector(inBackground: #selector(fetchJson), with: nil)
        
        
        
    }
    
    
   @objc func fetchJson() {
        

        let urlString: String
        if navigationController?.tabBarItem.tag == 0 {
            
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
            
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
      
            
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
            //we are ok to parse
                
                
               parse(json: data)
           return
            }
        }
            
       performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
        
    }
    
    func parse(json: Data) {
        
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json)
        {
            
            petitions = jsonPetitions.results
                        
            tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
            
        } else {
            performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
        }
    }
    
    @objc func filterPetitions() {
        
        let ac = UIAlertController(title: "Filter petitions", message: nil, preferredStyle: .alert)
        
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Filter", style: .default) {
            [weak self, weak ac] action in
            
                        
            guard let filteredItem = ac?.textFields?[0].text else { return }
            
            
            self?.filter(filterItem: filteredItem)
            
        }
        
        
        
        ac.addAction(submitAction)
        present(ac, animated: true)
        
    }
    
    func filter(filterItem: String) {
      if filterItem.isEmpty {
        filteredPetitions = petitions
        return
      }
      else {
        for petition in petitions {
          if petition.title.contains(filterItem) || petition.body.contains(filterItem) {
            filteredPetitions.append(petition)
            tableView.reloadData()
          }
        }
    }
    }
    
    @objc func shareCredits () {
        
        let ac = UIAlertController(title: "CREDITS", message: "This data comes from the We The People API of Whitehouse", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        
        present(ac, animated: true)
        
    }
    
  @objc  func showError() {
        
       
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        
    }
    
   

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPetitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let petition = filteredPetitions[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        
        
        vc.detailItem = filteredPetitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }

}

