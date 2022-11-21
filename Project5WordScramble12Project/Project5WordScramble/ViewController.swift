//
//  ViewController.swift
//  Project5WordScramble
//
//  Created by COBE on 09.08.2022..
//

import UIKit

class ViewController: UITableViewController {

    
    var allWords = [String]()
    var usedWords = [String] ()
    
    var gameState = GameState(currentWord: "", usedWords: [String]())
    
    let gameStateKey = "GameState"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Restart", style: .plain, target: self, action: #selector(restartGame))
        
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt" ) {
            
            if let startWords = try? String(contentsOf: startWordsURL) {
                
                allWords = startWords.components(separatedBy: "\n")
            }
            
        }
        
        if allWords.isEmpty {
            allWords = ["silkworm"]
        }
        
        
        
        performSelector(inBackground: #selector(loadGameState), with: nil)
    }
    
    @objc func loadGame() {
        
        if gameState.currentWord.isEmpty {
            performSelector(onMainThread: #selector(startNewGame), with: nil, waitUntilDone: false)
        }
        
        else {
            
            performSelector(onMainThread: #selector(loadGameState), with: nil, waitUntilDone: false)
        }
        
    }
    
    @objc func loadGameState() {
        
        let userDefaults = UserDefaults.standard
        if let loadedState = userDefaults.object(forKey: gameStateKey) as? Data {
            let decoder = JSONDecoder()
            if let decodedState = try? decoder.decode(GameState.self, from: loadedState) {
                gameState = decodedState
            }
        }
    }
    
    @objc func loadGameStateView() {
        title = gameState.currentWord
        tableView.reloadData()
    }
    
    @objc func startNewGame() {
        
        gameState.currentWord = allWords.randomElement() ?? "silkworm"
        gameState.usedWords.removeAll(keepingCapacity: true)
        
        DispatchQueue.global().async {
            [weak self] in
            self?.saveGameState()
            
            DispatchQueue.global().async {
                [weak self] in
                self?.loadGameState()
            }
        }
        
    }
    
    @objc func saveGameState() {
        
        let encoder = JSONEncoder()
        
        if let encodedState = try? encoder.encode(gameState) {
            let userDefaults = UserDefaults.standard
            userDefaults.set(encodedState, forKey: gameStateKey)
        }
        
    }
    
    func startGame() {
        
        title = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    
    @objc func restartGame() {
        
        startGame()
        
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        
        cell.textLabel?.text = usedWords[indexPath.row]
        
        return cell
    }
    
    @objc func promptForAnswer() {
        
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        
        ac.addTextField()

        let submitAction = UIAlertAction(title: "Submit", style: .default) {
            [weak self, weak ac] action in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submit(answer)
                    
        }
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func submit(_ answer: String) {
        
        let lowerAnwer = answer.lowercased()
        let errorTitle: String
        let errorMessage: String
        
        if isPossible(word: lowerAnwer) {
            if isOriginal(word: lowerAnwer) {
                if isReal(word: lowerAnwer) {
                    usedWords.insert(answer, at: 0)
                    
                    let indexPath = IndexPath(row: 0, section: 0)
                    tableView.insertRows(at: [indexPath], with: .automatic)
                    
                    return
                } else {
                    errorTitle = "Word to short or not recognized"
                    errorMessage = "You cant just make them up"
                    /*showErrorMessage(title: , errorMessage: )*/
                }
            } else {
                errorTitle = "Word already used"
                errorMessage = "Be more original"
            }
        } else {
            
            guard let title = title else {return}
            errorTitle = "Word not possible"
            errorMessage = "You cant spell that word from \(title.lowercased())."
        }
        
        let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        
        present(ac, animated: true)
    }
    
    /*func showErrorMessage(title: String, errorMessage: String) {
        
        
        
    }*/
    func isPossible(word: String) -> Bool {
        
        guard var tempWord = title?.lowercased() else { return false}
        
        if tempWord == word.lowercased() {
            return false
        }
        
        for letter in word {
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position)
            } else {
                return false
            }
        }
        return true
    }
    
    func isOriginal(word: String) -> Bool {
        
        
        return !usedWords.contains(word)
    }
    
    func isReal(word: String) -> Bool {
        
        
        
        if word.count < 3
        {
            return false
        }
        
        
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        
        return misspelledRange.location == NSNotFound
    }
}

