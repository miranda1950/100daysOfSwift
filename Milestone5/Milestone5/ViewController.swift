//
//  ViewController.swift
//  Milestone5
//
//  Created by COBE on 22.08.2022..
//

import UIKit

class ViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var pictures = [Data2] ()

    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPicture))
        
        self.tableView.rowHeight = 100
        
        let defaults = UserDefaults.standard
        
        if let savedPictures = defaults.object(forKey: "Pictures") as? Data {
            
            let jsonDecoder = JSONDecoder()
            
            
            do {
                
              pictures = try jsonDecoder.decode([Data2].self, from: savedPictures)
            } catch {
                print("Unable to load pictures")
            }
                
        }
            
        
        
    }
    
    
    @objc func addNewPicture() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let ac = UIAlertController(title: "Source", message: nil, preferredStyle: .actionSheet)
            ac.addAction(UIAlertAction(title: "Galery", style: .default, handler: { [weak self] _ in
                
                self?.showPicker(fromCamera: false)
            }))
            ac.addAction(UIAlertAction(title: "Camera", style: .default, handler: {
                
                [weak self] _ in
                
                self?.showPicker(fromCamera: true)
            }))
            
            ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
            present(ac, animated: true)
        } else {
            showPicker(fromCamera: false)
        }
        
    }
    
    func showPicker(fromCamera: Bool) {
        
        let picker = UIImagePickerController()
        
        picker.allowsEditing = true
        picker.delegate = self
        if fromCamera {
            picker.sourceType = .camera
        }
        present(picker,animated: true)
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PictureCaption", for: indexPath) as? ImageCell else {
            
            fatalError("Unable to deque PictureCaption")
        }
        
        let object = pictures[indexPath.row]
        cell.caption.text = object.imageCaption
        
        let path = getDocumentsDirectory().appendingPathComponent(object.imageName)
        
        cell.imageView?.image = UIImage(contentsOfFile: path.path)
        cell.imageView?.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        cell.imageView?.layer.borderWidth = 2
        cell.imageView?.layer.cornerRadius = 3
        cell.layer.cornerRadius = 7
        
        return cell
        
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        return paths[0]
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.editedImage] as? UIImage else { return }
        
        
        let imageName = UUID().uuidString
        
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            
            try? jpegData.write(to: imagePath)
        }
        
        dismiss(animated: true)
        
        let ac = UIAlertController(title: "Caption", message: "enter a caption", preferredStyle: .alert)
        ac.addTextField()
        
        ac.addAction((UIAlertAction(title: "ok", style: .default, handler: {
            
            [weak ac] _ in
            guard let caption = ac?.textFields?[0].text else { return }
            self.savePicture(imageName: imageName, caption: caption)
        })))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
    
        present(ac, animated: true)
    }
    
    func savePicture(imageName: String, caption: String) {
        
        let picture = Data2(imageName: imageName, imageCaption: caption)
        
        pictures.append(picture)
        
        let jsonEncoder = JSONEncoder()
        
        if let savedData = try? jsonEncoder.encode(pictures) {
            
            let defaults = UserDefaults.standard
            
            defaults.set(savedData, forKey: "Pictures")
            
        } else {
            
            print("Failed to save picture")
        }
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            
            vc.pictures = pictures
            vc.currentPicture = indexPath.row

            
            navigationController?.pushViewController(vc, animated: true)
            
        }
        
            
    }
   
}

