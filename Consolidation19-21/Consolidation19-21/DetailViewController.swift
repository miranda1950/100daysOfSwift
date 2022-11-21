//
//  DetailViewController.swift
//  Consolidation19-21
//
//  Created by COBE on 29.08.2022..
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var textView: UITextView!
    
    var detailNote: Note = Note(title: "", body: "")
    var currentNote = Storage.loadPages()
    var isNewNote = true
    
        
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        title = detailNote.title
        textView.text = detailNote.body
        
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveNote))
        self.navigationController?.isToolbarHidden = false
        setToolbarItems([saveButton], animated: true)
        
    }
    
    @objc func saveNote () {
        
        detailNote.body = textView.text
        
        guard !isNewNote, let originalIndex = noteIndex else {
            currentNote.append(detailNote)
            Storage.save(notepad: currentNote)
            isNewNote = false
            return
        }
        
        currentNote[originalIndex] = detailNote
        Storage.save(notepad: currentNote)

    }
    
}

  


