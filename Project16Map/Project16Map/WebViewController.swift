//
//  WebViewController.swift
//  Project16Map
//
//  Created by COBE on 25.08.2022..
//

import WebKit
import UIKit

class WebViewController: UIViewController {

    @IBOutlet var webView: WKWebView!
    
    var website: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard website != nil else {
            print("Website not set")
            navigationController?.popViewController(animated: true)
            return
        }
        
        if let url = URL(string: website) {
        webView.load(URLRequest(url: url))
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
