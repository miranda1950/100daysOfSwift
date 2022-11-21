//
//  ViewController.swift
//  Consolidation28-30
//
//  Created by COBE on 05.09.2022..
//

import UIKit

class ViewController: UICollectionViewController {

    let pictures = ["estonia","france", "germany","ireland"]
    
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return pictures.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemoryPicture", for: indexPath)
        
        if let imageView = cell.viewWithTag(1000) as? UIImageView {
            imageView.image = UIImage(named: pictures[indexPath.item])
            
        }
        return cell
    }
    
    
}

