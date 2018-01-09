//
//  ViewController.swift
//  AppLabs
//
//  Created by test on 08/01/2018.
//  Copyright © 2018 Grey. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func copyToClipboard(_ sender: Any) {
        UIPasteboard.general.string = label.text
    }
    
    @IBAction func loadPhoto(_ sender: Any) {
        showAlert()
    }
}

extension ViewController {
    
    private func takePhoto(_ sourceType: UIImagePickerControllerSourceType ) {
        
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        imagePicker.allowsEditing = true
        
        if sourceType == .camera {
            imagePicker.cameraFlashMode = .off
        }
        
        present(imagePicker, animated: true, completion: nil)
    }
    
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        guard let image =  info[UIImagePickerControllerEditedImage] as? UIImage else { return }
        imageView.image = image
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)
    }
}

extension ViewController {
    
    private func showAlert() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let takePhotoAction = UIAlertAction(title: "Take a Profile Picture", style: .default) { (action) in
            self.takePhoto(.camera)
        }
        
        let selectAction = UIAlertAction(title: "Select Profile Picture", style: .default) { (action) in
            self.takePhoto(.photoLibrary)
        }
        
        let dismissAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(takePhotoAction)
        alertController.addAction(selectAction)
        alertController.addAction(dismissAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}

