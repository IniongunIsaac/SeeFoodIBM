//
//  ViewController.swift
//  SeeFoodIBM
//
//  Created by Isaac Iniongun on 25/04/2019.
//  Copyright © 2019 Isaac Iniongun. All rights reserved.
//

import UIKit
import VisualRecognition

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let apiKey = "Dm8lBsmIp1EZMALau86lbAY6MOHSdTeKGolGOiJwNEBH"
    let version = "2019-04-26"

    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    
    private var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        imagePicker.delegate = self
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            imageView.image = image
            
            imagePicker.dismiss(animated: true, completion: nil)
            
            let visualRecognition = VisualRecognition(version: version, apiKey: apiKey)
            
            let imageData = image.jpegData(compressionQuality: 0.01)
            
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            
            let fileURL = documentsURL.appendingPathComponent("tempImage.jpg")
            
            try? imageData?.write(to: fileURL, options: [])
            
            visualRecognition.classify(image: image) { (classifiedImages, error) in
                print("Classification: \(classifiedImages?.result?.images)")
            }
            
        } else {
            print("There was an error picking the image.")
        }
        
    }

    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = false
        
        present(imagePicker, animated: true, completion: nil)
        
    }
}

