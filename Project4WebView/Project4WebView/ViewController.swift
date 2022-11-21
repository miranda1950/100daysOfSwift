//
//  ViewController.swift
//  Project4WebView
//
//  Created by COBE on 08.08.2022..
//

import UIKit
import WebKit


class ViewController: UIViewController, WKNavigationDelegate {

    var webView: WKWebView!
    var progressView: UIProgressView!
    var websites: [String]!
    var currentWebsite: Int!
    
   
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard websites != nil && currentWebsite != nil else {
            print("Website not set")
            
            navigationController?.popViewController(animated: true)
            return
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        
        let back = UIBarButtonItem(title: "Back", style: .plain, target: webView, action: #selector(webView.goBack))
        
        let forward = UIBarButtonItem(barButtonSystemItem: .fastForward, target: webView, action: #selector(webView.goForward))
        
        
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        
        let progressButton = UIBarButtonItem(customView: progressView)
        
        
        
        toolbarItems = [progressButton, spacer, refresh, back,forward]
        navigationController?.isToolbarHidden = false
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
        
        
        let url = URL(string: "https://" + websites[0])!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        
        
    }

    
    

    @objc func openTapped() {
        
        let ac = UIAlertController(title: "Open Page...", message: nil, preferredStyle: .actionSheet)
        
        for website in websites {
        ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
        }
        
        ac.addAction(UIAlertAction(title: "badWebsite", style: .default, handler: openPage))
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }
    
    func openPage(action: UIAlertAction) {
       /* guard let actionTitle = action.title else { return }
        
        guard let url = URL(string: "https:\\" + actionTitle) else { return } */
        
        let url = URL(string: "https://" + action.title!)!
        webView.load(URLRequest(url : url))
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {            progressView.progress = Float(webView.estimatedProgress)
        }
    }

    /* funkcija koja dozvoljava permission za navigiranje na drugi content u ovisnosti o funckiji ispod*/
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        let url = navigationAction.request.url
        
        if let host = url?.host {
            for website in websites {
                if host.contains(website) {
                    decisionHandler(.allow)
                    return
                }
            }
            
        }
        
        
       
        let urlString = url?.absoluteString ?? "Unknown"
        
        if urlString != "about:blank"{
        let ac = UIAlertController(title: "BLOCKED WEBSITE", message: "Requested url is not safe", preferredStyle: .alert)
         ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            present(ac, animated: true) }
        decisionHandler(.cancel)
        
        }
        

        
    }



