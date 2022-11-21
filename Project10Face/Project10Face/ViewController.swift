//
//  ViewController.swift
//  Project10Face
//
//  Created by COBE on 16.08.2022..
//

import UIKit

class ViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var people = [Person] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPerson))
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return people.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as? PersonCell else {
            
            fatalError("Unable to deque PersonCell")
            
        }
        
        
        let person = people[indexPath.item]
        
        cell.name.text = person.name
        
        let path = getDocumentsDirectory().appendingPathComponent(person.image)
        
        cell.imageView.image = UIImage(contentsOfFile: path.path)
        
        cell.imageView.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        cell.imageView.layer.borderWidth = 2
        cell.imageView.layer.cornerRadius = 3
        cell.layer.cornerRadius = 7
        
        
        return cell
    }
    
    @objc func addNewPerson() {
          if UIImagePickerController.isSourceTypeAvailable(.camera) {
              let ac = UIAlertController(title: "Source", message: nil, preferredStyle: .actionSheet)
              ac.addAction(UIAlertAction(title: "Photos", style: .default, handler: { [weak self] _ in
                  self?.showPicker(fromCamera: false)
              }))
              ac.addAction(UIAlertAction(title: "Camera", style: .default, handler: { [weak self] _ in
                  self?.showPicker(fromCamera: true)
              }))
              ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
              ac.popoverPresentationController?.barButtonItem = navigationItem.leftBarButtonItem
              
              present(ac, animated: true)
          }
          else {
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
          present(picker, animated: true)
      }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        let imageName = UUID().uuidString
        
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            
            try? jpegData.write(to: imagePath)
        }
        
        let person = Person(name: "Unknown", image: imageName)
        people.append(person)
        collectionView.reloadData()
        
        dismiss(animated: true)
        
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        return paths[0]
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           let person = people[indexPath.item]

           let ac = UIAlertController(title: "Person", message: nil, preferredStyle: .actionSheet)
           ac.addAction(UIAlertAction(title: "Rename person", style: .default, handler: { [weak self] action in
               self?.renamePersonTapped(person)
           }))
           ac.addAction(UIAlertAction(title: "Delete person", style: .destructive, handler: { [weak self] action in
               self?.deletePersonChosen(at: indexPath)
           }))
           ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
           // provide the source for ipad compatibility
           if let popoverController = ac.popoverPresentationController {
               if let cellView = collectionView.cellForItem(at: indexPath) {
                   popoverController.sourceView = cellView
                   popoverController.sourceRect = CGRect(x: cellView.bounds.midX, y: cellView.bounds.midY, width: 0, height: 0)
               }
           }
           present(ac, animated: true)
       }
    
    
    func renamePersonTapped(_ person: Person) {
           let ac = UIAlertController(title: "Rename person", message: nil, preferredStyle: .alert)
           ac.addTextField()
           
           ac.addAction(UIAlertAction(title: "OK", style: .default) { [weak self, weak ac] _ in
               guard let newName = ac?.textFields?[0].text else {
                   return
               }
               person.name = newName
               self?.collectionView.reloadData()
           })
           
           ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
           present(ac, animated: true)
       }
    
    func deletePersonChosen(at indexPath: IndexPath) {
        
        let ac = UIAlertController(title: "Confirm", message: "Do you want to delete that person", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.addAction(UIAlertAction(title: "Delete", style: .default, handler: {
            [weak self] _ in
            self?.deletePerson(at: indexPath)
            
            
        }))
        
        
    }
    
    func deletePerson(at indexPath: IndexPath) {
        
        DispatchQueue.global().async { [weak self] in
                    guard let image = self?.people[indexPath.item].image else {
                        self?.showDeleteError()
                        return
                    }
                    
                    guard let imagePath = self?.getDocumentsDirectory().appendingPathComponent(image) else {
                        self?.showDeleteError()
                        return
                    }
                    
                    do {
                        try FileManager.default.removeItem(at: imagePath)
                    }
                    catch {
                        self?.showDeleteError()
                        return
                    }

                    // deletion ok
                    self?.people.remove(at: indexPath.item)

                    DispatchQueue.main.async {
                        self?.collectionView.deleteItems(at: [indexPath])
                    }
                }
        
    }
    
    func showDeleteError() {
        
        DispatchQueue.main.async { [weak self] in
                    let ac = UIAlertController(title: "Error", message: "Person could not be deleted", preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "OK", style: .default))
                    
                    self?.present(ac, animated: true)
                }
            }
    }
    

                
