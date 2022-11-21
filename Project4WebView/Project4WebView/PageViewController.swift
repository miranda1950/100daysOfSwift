//
//  PageViewController.swift
//  Project4WebView
//
//  Created by COBE on 08.08.2022..
//

import UIKit
import WebKit

class PageViewController: UITableViewController {

    var websites = ["apple.com", "hackingwithswift.com"]
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websites.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableSites", for: indexPath)
        
        cell.textLabel?.text = websites[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "WebView") as! ViewController
        
        vc.websites = websites
        vc.currentWebsite = indexPath.row
        navigationController?.pushViewController(vc, animated: true)
        
        
        
    }
    

    

}
