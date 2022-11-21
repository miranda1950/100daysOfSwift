//
//  ViewController.swift
//  Consolidation19-21
//
//  Created by COBE on 29.08.2022..
//

import UIKit

class ViewController: UITableViewController {

    
    var notes = Storage.loadPages()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "iOS Notepad"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewNote))
        
       
    }
    
    @objc func addNewNote() {
        
        let ac = UIAlertController(title: "New Note", message: "Please enter the title", preferredStyle: .alert)
        
        ac.addTextField()
        ac.textFields?.first?.placeholder = "Enter note title"
        
        let submitAction = UIAlertAction(title: "Add", style: .default) {
            [weak self, weak ac] action in
            
            guard let answer = ac?.textFields?[0].text, answer != "" else { return }
            self?.submit(answer)
            
        }
        ac.addAction(submitAction)
        
        present(ac, animated: true)
    }
    
    func submit(_ answer: String) {
        
           if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
               
               vc.detailNote = Note(title: answer, body: "")
                navigationController?.pushViewController(vc, animated: true)
            
        }
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let data = notes[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = data.title
        cell.detailTextLabel?.text = data.body
                return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.detailNote = notes[indexPath.row]
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}

