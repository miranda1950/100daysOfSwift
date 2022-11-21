//
//  DetailViewController.swift
//  Milestone5
//
//  Created by COBE on 22.08.2022..
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var detailImage: UIImageView!
    
    var pictures: [Data2]!
    
    var selectedImage: Data2!
    
    var currentPicture:  Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        selectedImage = pictures[currentPicture]
        
        title = selectedImage.imageCaption
     
        let path = Utils.getImageUrl(for: selectedImage.imageName)
        detailImage.image = UIImage(contentsOfFile: path.path)
        
    /*   if let imageToLoad = selectedImage {
           detailImage.image = UIImage(contentsOfFile: path)
     } */
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
