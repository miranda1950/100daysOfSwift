//
//  ViewController.swift
//  Consolidation19-21Miran
//
//  Created by COBE on 01.09.2022..
//

import UIKit

class ViewController: UITableViewController {
    
    var notes = [Note] ()
    
    override func viewWillAppear(_ animated: Bool) {
        performSelector(inBackground: #selector(loadNotes), with: nil)
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "iOS Notes"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewNote))
        
        self.tableView.rowHeight = 100
        
      /*  let defaults = UserDefaults.standard
        if let savedNotes = defaults.object(forKey: "notepads") as? Data {
            let jsonDecoder = JSONDecoder()
            
            do {
                notes = try jsonDecoder.decode([Note].self, from: savedNotes)
            } catch {
                
               print("Unable to load")
            }
        }
        */
            
        
    }
    
    @objc func loadNotes(){
        let defaults = UserDefaults.standard
        if let savedNotes = defaults.object(forKey: "notepads") as? Data {
            let jsonDecoder = JSONDecoder()
            
            do {
                notes = try jsonDecoder.decode([Note].self, from: savedNotes)
            } catch {
                
               print("Unable to load")
            }
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
       let note = notes[indexPath.row]
        
        cell.textLabel?.text = note.title
       cell.detailTextLabel?.text = note.body
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailNoteViewController {
            
           vc.detailNote = notes[indexPath.row]
           vc.currentNote = indexPath.row
           
           
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    
    @objc func addNewNote() {
        
        let ac = UIAlertController(title: "Add new title of Note", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.textFields?.first?.placeholder = "Enter new title"
        
        let submitAction = UIAlertAction(title: "Add", style: .default) {
            [weak self, weak ac] action in
            
            guard let answer = ac?.textFields?[0].text else { return }
            
            self?.submit(answer)
            self?.saveNoteAnswer(answer)
            
        }
        ac.addAction(submitAction)
        present(ac, animated: true)
        
    }
    
    func saveNoteAnswer(_ answer: String) {
        let note = Note(title: answer, body: "")
        
        notes.append(note)
        let jsonEncoder =  JSONEncoder()
        if let savedData = try? jsonEncoder.encode(notes) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "notepads")
            
        } else {
            print("Unable to save")
        }
        tableView.reloadData()
            
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            updateAfterDelete()
        }
    }
   
    private func updateAfterDelete() {
        let jsonEncoder = JSONEncoder()
        
        if let updatedNotes = try? jsonEncoder.encode(notes) {
            UserDefaults.standard.set(updatedNotes, forKey: "savedNotes")
        } else {
            fatalError("Unable to update notes after deletion.")
        }
    }
    
    func submit(_ answer: String) {
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailNoteViewController {
    
            vc.detailNote = Note(title: answer, body: "")
            
            navigationController?.pushViewController(vc, animated: true)
            
        }
        
        
    }

    
}

