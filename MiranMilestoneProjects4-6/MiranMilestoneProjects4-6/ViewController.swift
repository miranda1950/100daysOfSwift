//
//  ViewController.swift
//  MiranMilestoneProjects4-6
//
//  Created by COBE on 10.08.2022..
//

import UIKit

class ViewController: UITableViewController {
    
    
    var shoppingList = [String] ()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewItem))
        
        let share = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        navigationItem.rightBarButtonItems = [add, share]
        
      /*  navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewItem))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped)) */
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Clear", style: .plain , target: self, action: #selector(clearList))
        
    }
    
    
    @objc func shareTapped() {
        
        let list = shoppingList.joined(separator: "\n")
        
        let vc = UIActivityViewController(activityItems: [list], applicationActivities: [])
        
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
        
    }
    
    @objc func clearList() {
        
        shoppingList.removeAll()
        tableView.reloadData()
        
    }
    
    
    @objc func addNewItem() {
        
        let ac = UIAlertController(title: "Add New Item", message: nil, preferredStyle: .alert)
        
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Add", style: .default)
        {
            [weak self, weak ac] action in
            guard let item = ac?.textFields?[0].text else {return}
            
            
            self?.submit(item: item)
            
        }
        
        ac.addAction(submitAction)
        
        present(ac, animated: true)
        
    }
    
    func submit (item: String) {
        
        
            shoppingList.insert(item, at: 0)
           
           let indexPath = IndexPath(row: 0, section: 0)
           
           tableView.insertRows(at: [indexPath], with: .automatic)
            
        
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingItems", for: indexPath)
        
        cell.textLabel?.text = shoppingList[indexPath.row]
        
        return cell
    }
    
    


}

