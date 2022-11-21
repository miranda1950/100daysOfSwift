//
//  ViewController.swift
//  Consolidation25-27
//
//  Created by COBE on 02.09.2022..
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var imageView: UIImageView!
    var image: UIImage?
    var topText: String?
    var bottomText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPicture))
        
        let addTopText = UIBarButtonItem(title: "Top Text", style: .plain, target: self, action: #selector(addTopText))
        let addBottomText = UIBarButtonItem(title: "Bottom Text", style: .plain, target: self, action: #selector(addBotText))
        
        navigationItem.leftBarButtonItems = [addTopText, addBottomText]
    }
    
    @objc func addTopText() {
        
        let ac = UIAlertController(title: "Top Caption", message: "please enter a top caption", preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.addAction(UIAlertAction(title: "Add", style: .default, handler: {
            [weak self, weak ac] _ in
        guard let text = ac?.textFields?[0].text else { return }
            
            self?.topText = text
            self?.addMemeText()
        }))
        
        present(ac, animated: true)
        
    }
    
    @objc func addBotText() {
        let ac = UIAlertController(title: "Bottom Caption", message: "please enter a bottom caption", preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.addAction(UIAlertAction(title: "Add", style: .default, handler: {
            [weak self, weak ac] _ in
        guard let text = ac?.textFields?[0].text else { return }
            
            self?.bottomText = text
            self?.addMemeText()
        }))
        
        present(ac, animated: true)
    }

    
    func addMemeText() {
        
        guard let image = image else { return }
        
        let renderer = UIGraphicsImageRenderer(size: image.size)
        
        let renderedImage = renderer.image {
            [weak self ] ctx in
            image.draw(at: CGPoint(x: 0, y: 0))
            
            if let topText = self?.topText {
                drawText(text: topText, rendererSize: image.size)
            }
            if let bottomText = self?.bottomText {
                drawText(text: bottomText, rendererSize: image.size)
            }
        }
        imageView.image = renderedImage
    }
    
    func drawText(text: String, rendererSize: CGSize) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment  = .center
        let sidesLength =  rendererSize.width + rendererSize.height
        let fontSize = sidesLength / 30
        
        let attrs: [NSAttributedString.Key : Any] = [
            .strokeColor:UIColor.black,
            .strokeWidth: -2.0,
            .foregroundColor: UIColor.white,
            .font:UIFont(name: "HelveticaNeue", size: fontSize)!,
            .paragraphStyle: paragraphStyle
            
        ]
        
        let margin = 32
        let textWidth = Int(rendererSize.width) - (margin * 2)
        let textHeight = resizeHeight(for: text, attributes: attrs, width: textWidth)
        
        var startY:Int
        startY = margin
        
        let attributedString = NSAttributedString(string: text, attributes: attrs)
        attributedString.draw(with: CGRect(x: margin,y: startY, width: textWidth, height: textHeight),options: .usesLineFragmentOrigin,
        context: nil)
    }
    
    func resizeHeight(for text: String, attributes: [NSAttributedString.Key: Any], width: Int) -> Int {
        let nsText = NSString( string: text)
        
        let size  = CGSize(width: CGFloat(width), height: .greatestFiniteMagnitude)
        let textRect = nsText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        
        return  Int(ceil(textRect.size.height))
    }
    
    @objc func addNewPicture(){
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let ac = UIAlertController(title: "Source", message: nil, preferredStyle: .actionSheet)
            ac.addAction(UIAlertAction(title: "Galery", style:
                    .default, handler: {
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
        
        picker.allowsEditing  = true
        picker.delegate = self
        if fromCamera {
            picker.sourceType = .camera
        }
        present(picker, animated: true)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else  { return
            
        }
        let imageName = UUID().uuidString
        
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            
            try? jpegData.write(to: imagePath)
        }
        
       dismiss(animated: true)
        
        imageView.image = image
        self.image = image
        
            
        
    }

    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        return paths[0]
    }
}

