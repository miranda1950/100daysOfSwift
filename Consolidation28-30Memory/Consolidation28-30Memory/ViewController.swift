//
//  ViewController.swift
//  Consolidation28-30Memory
//
//  Created by COBE on 05.09.2022..
//

import UIKit

class ViewController: UICollectionViewController {

    let images = ["estonia", "france", "germany", "ireland","spain"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Picture", for: indexPath) as! PictureCell
        
        cell.imageView.image = UIImage(named: images[indexPath.row])
        return cell
    }

    
}

