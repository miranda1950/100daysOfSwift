//
//  DetailViewController.swift
//  Project1.1
//
//  Created by COBE on 05.08.2022..
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?
    var selectedPicturePosition = 0
    var totalPictures = 0
      
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        title = "picture \(selectedPicturePosition) of \(totalPictures)"
        
        navigationItem.largeTitleDisplayMode
        = .never
        
        if let imageToLoad = selectedImage{
            imageView.image = UIImage(named: imageToLoad)
            
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
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