//
//  DetailNoteViewController.swift
//  Consolidation19-21Miran
//
//  Created by COBE on 01.09.2022..
//

import UIKit

class DetailNoteViewController: UIViewController {

    
    @IBOutlet var textView: UIView!
    @IBOutlet var realTextView: UITextView!
    
   // var detailNote: [Note]!
    var currentNote: Int!
    var selectedNode = Storage.loadPages()
    var detailNote: Note = Note(title: "", body: "")

    var isNewNote = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = detailNote.title
        realTextView.text = detailNote.body
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveNote))
    
    }
    
    
    @objc func saveNote() {
        
        
        let newNote = Note(title: detailNote.title, body: realTextView.text)
        
        selectedNode.append(newNote)
        let jsonEncoder = JSONEncoder()
        
        if let savedData = try? jsonEncoder.encode(selectedNode) {
            let defaults = UserDefaults.standard
            
            defaults.set(savedData, forKey: "notepads")
            
        } else {
            print("unabel to load from detailview")
        }
            
       
        

    
    }
}
