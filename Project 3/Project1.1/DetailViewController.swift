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

        
        guard let selectedImage = selectedImage else {
            print("No image found")
            return
        }

        title = "picture \(selectedPicturePosition) of \(totalPictures)"
        
        navigationItem.largeTitleDisplayMode
        = .never
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        imageView.image = UIImage(named: selectedImage)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }

   @objc func shareTapped() {
      
       guard let image = imageView.image else {
           print("no image found")
           return
       }
       let watermarkedImage = watermark(image: image)
       
       var shareable: [Any] = [watermarkedImage]
       if let imageText = selectedImage {
           shareable.append(imageText)
       }
       
       let vc = UIActivityViewController(activityItems: shareable, applicationActivities: [])
               // mandatory on ipad to show where the sharing comes from
               vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
               present(vc, animated: true)
       
       
     
    
    
   }



func watermark(image: UIImage) -> UIImage {
    
    let renderer = UIGraphicsImageRenderer(size: image.size)
    
    let renderedImage = renderer.image {
        ctx in image.draw(at: CGPoint(x: 0, y: 0))
        
        let parahraphStyle = NSMutableParagraphStyle()
        parahraphStyle.alignment = .left
        let string = "From Storm Viewer"
        
        let attrs: [NSAttributedString.Key: Any] = [
            .strokeColor: UIColor.black,
            .strokeWidth: -1.0,
            .foregroundColor: UIColor.black,
            .font: UIFont(name: "HelveticaNeue", size: 36)!,
            .paragraphStyle: parahraphStyle
            
        ]
        
        let margin = 32
        let textWidth = Int(image.size.width) - (margin * 2)
        let textHeight = Int(image.size.height) - (margin * 2)
        string.draw(with: CGRect(x: margin, y: margin, width: textWidth, height: textHeight), options: .usesLineFragmentOrigin, attributes: attrs, context: nil)
      
    }
    
   return renderedImage
    
}

}
