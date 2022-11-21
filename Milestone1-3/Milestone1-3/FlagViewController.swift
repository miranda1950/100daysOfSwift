//
//  FlagViewController.swift
//  Milestone1-3
//
//  Created by COBE on 08.08.2022..
//

import UIKit


class FlagViewController: UIViewController {

    
    
    @IBOutlet var flagImage: UIImageView!
    
    var selectedImage: String?
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareFlag))
        if let imageToLoad = selectedImage {
            flagImage.image = UIImage(named: imageToLoad)
        }
    }
    
    
    @objc func shareFlag() {
        
        guard let image = flagImage.image?.jpegData(compressionQuality: 0.8) else {
            print("Image is not found")
            return
        }
                
        if let imageToLoad = selectedImage {
            
            let vc = UIActivityViewController(activityItems: [image,imageToLoad], applicationActivities: [])
            
            vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
            
            present(vc, animated: true)
        }
                
        
        
    }
    

   

}
