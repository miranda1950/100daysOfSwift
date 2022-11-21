//
//  ViewController.swift
//  Milestone4-HANGMAN
//
//  Created by COBE on 17.08.2022..
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var wordLabel: UILabel!
    
        var allWords = [String] ()
    
    var currentAnswer: UITextField!
        var usedLetters = [String] ()
        var wrongAnswers = [String] ()
        var letterButtons = [UIButton] ()
        
    override func loadView() {
        
        view = UIView()
        view.backgroundColor = .white
        
        
        wordLabel.translatesAutoresizingMaskIntoConstraints = false
        wordLabel.textAlignment = .right
        wordLabel.text = "Score: 0"
        view.addSubview(wordLabel)
        
        currentAnswer = UITextField ()
        currentAnswer.translatesAutoresizingMaskIntoConstraints = false
        
        currentAnswer.placeholder = "Tap letters to guess"
        currentAnswer.textAlignment = .center
        currentAnswer.font = UIFont.systemFont(ofSize: 44)
        currentAnswer.isUserInteractionEnabled = false
        view.addSubview(currentAnswer)
        
        
        
        let buttonsView = UIView ()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsView)
        
        buttonsView.layer.borderWidth = 1
        buttonsView.layer.borderColor = UIColor.lightGray.cgColor
        
        
        NSLayoutConstraint.activate([
        
            wordLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            wordLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
        
        
        
        
        
        
        
        ])
        
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Start", style: .plain, target: self, action: #selector(loadWord))
        
        
        
        
}
    
    @objc func loadWord() {
        
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt" ) {
            
            if let startWords = try? String(contentsOf: startWordsURL) {
                
                allWords = startWords.components(separatedBy: "\n")
            }
            
        }
        
        if allWords.isEmpty {
            allWords = ["silkworm"]
        }
        
    }
    
    

}
