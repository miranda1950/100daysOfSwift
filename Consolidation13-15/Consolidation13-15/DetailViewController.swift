//
//  DetailViewController.swift
//  Consolidation13-15
//
//  Created by COBE on 24.08.2022..
//

import UIKit
import WebKit


class DetailViewController: UIViewController {

    
    
    
    var webView: WKWebView!
    var detailItem: Country?
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(share))
        
        
        guard let detailItem = detailItem else {
            return
        }

        let html = """
            <html>
            <head>
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <style> body { font-size: 150%; } </style>
            </head>
            <body>
            \(detailItem.body)
            </body>
            </html>
            """

            webView.loadHTMLString(html, baseURL: nil)
    }
    
    @objc func share() {
        let items: [String] = ["Best app there is,you should really try it"]
        
        
        let vc = UIActivityViewController(activityItems: items, applicationActivities: [])
        
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
        
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
