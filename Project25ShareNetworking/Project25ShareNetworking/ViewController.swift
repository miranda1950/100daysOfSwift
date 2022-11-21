//
//  ViewController.swift
//  Project25ShareNetworking
//
//  Created by COBE on 30.08.2022..
//

import UIKit
import MultipeerConnectivity

class ViewController: UICollectionViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, MCSessionDelegate, MCBrowserViewControllerDelegate {

    var images = [UIImage] ()
    
    var peerID = MCPeerID(displayName: UIDevice.current.name) // identifies each user uniqly in session
    var mcSession: MCSession? // handles multi peer connectivity for us
    var mcAdvertiserAssistant: MCAdvertiserAssistant? // used when creating a session telling other that we exists,,mcbrowsercontroller- used for looking for sessions
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        title = "Selfie Share"
        
        let importButton = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(importPicture))
        
        let connectionButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showConnectionPrompt))
        
        let allConnectedPeers = UIBarButtonItem(title: "Peers", style: .plain, target: self, action: #selector(showAllPeers))
        
        navigationItem.leftBarButtonItems = [connectionButton, allConnectedPeers]
        
        
        let sendMessageButton = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(showSendMessage))
        
        navigationItem.rightBarButtonItems = [importButton, sendMessageButton]
        
        mcSession = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
        
        mcSession?.delegate = self
        
    }
    
    @objc func showAllPeers() {
        
        var peersText = ""
        
        var peersAreAvailable = false
        if let mcSession = mcSession {
            if mcSession.connectedPeers.count > 0 {
                peersAreAvailable = true
                for peer in mcSession.connectedPeers {
                    peersText += "\(peer.displayName)"
                }
            }
        }
        
        if !peersAreAvailable {
            peersText += "\nNo peer Connected"
        }
    }
    
    @objc func showSendMessage() {
        let ac = UIAlertController(title: "Message", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .default))
        ac.addAction(UIAlertAction(title: "Send", style: .default, handler: {
            [weak self, weak ac] _ in
            if let text = ac?.textFields?[0].text {
                self?.sendMessage(text)
            }
        }))
        present(ac, animated: true)
    }
    
    func sendMessage(_ text: String) {
        let data = Data(text.utf8)
        sendData(data)
    }
    
    func sendData(_ data: Data) {
        guard let mcSession = mcSession else {
            return
        }
        if  mcSession.connectedPeers.count > 0 {
            do{
                try mcSession.send(data, toPeers: mcSession.connectedPeers, with: .reliable)
            }
            catch {
                let ac = UIAlertController(title: "Send error", message: error.localizedDescription, preferredStyle: .alert)
                                ac.addAction(UIAlertAction(title: "OK", style: .default))
                                present(ac, animated: true)
            }
        }
    }
    
    
    func startHosting(action: UIAlertAction) {
        
        guard let mcSession = mcSession else {
            return
        }

        mcAdvertiserAssistant = MCAdvertiserAssistant(serviceType: "hws-project25", discoveryInfo: nil, session: mcSession)
        mcAdvertiserAssistant?.start()
    }
    
    func joinSession(action: UIAlertAction) {
        guard let mcSession = mcSession else {
            return
        }

        let mcBrowser = MCBrowserViewController(serviceType: "hws-project25", session: mcSession)
        mcBrowser.delegate = self
        present(mcBrowser, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageView", for: indexPath)
        
        if let imageView = cell.viewWithTag(1000) as? UIImageView {
            imageView.image = images[indexPath.item]
    }
        return cell
        
    }
    
    
        
    
    @objc func importPicture() {
        
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker,animated: true)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        dismiss(animated: true)
        
        images.insert(image, at: 0)
        collectionView.reloadData()
        
        guard let mcSession = mcSession else {
            return
        }
        
        if mcSession.connectedPeers.count > 0 {
            if let imageData = image.pngData() {
                do {
                    try mcSession.send(imageData, toPeers: mcSession.connectedPeers, with: .reliable)
                } catch {
                    let ac = UIAlertController(title: "Send error", message: error.localizedDescription, preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "OK", style: .default))
                    present(ac, animated: true)
                }
            }
        }
    }
    
    @objc func showConnectionPrompt() {
        
        let ac =  UIAlertController(title: "Connect to othher", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "hOST A SESSION", style: .default, handler: startHosting))
        ac.addAction(UIAlertAction(title: "Join a session", style: .default, handler: joinSession))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac,animated: true)
                     
    }
    
    
    // tri funkcije moraju se napraviti ali ne trebaju za program pa su praznne
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        
    }
    
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true)
    }
    
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true)
    }
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case .notConnected:
            let ac = UIAlertController(title: "Oh!", message: "\(peerID.displayName) has disconeected", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        case .connecting:
            print("Connecting \(peerID.displayName)")
        case .connected:
            print("Connected \(peerID.displayName)")
        
        @unknown default:
            print("Unknown state received \(peerID.displayName)")
        }
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        DispatchQueue.main.async {
            [weak self] in
            
            if let image = UIImage(data: data) {
                self?.images.insert(image, at: 0)
                self?.collectionView.reloadData()
            }
        }
    }
}

