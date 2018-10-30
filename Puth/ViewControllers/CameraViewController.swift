//
//  CameraViewController.swift
//  Puth
//
//  Created by Zabeehullah Qayumi on 9/28/18.
//  Copyright © 2018 Zabeehullah Qayumi. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController {
    var selectedImage : UIImage?
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var captionTextView: UITextView!
    
    @IBOutlet weak var sharebutton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
            
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(CameraViewController.handleSelectPhoto))
        photo.addGestureRecognizer(tapGesture)
        photo.isUserInteractionEnabled = true

    }
    
    
    @objc func handleSelectPhoto(){
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        present(pickerController, animated: true, completion: nil)
        
        
    }

    
    @IBAction func shareButton(_ sender: Any) {
    }
    


}




extension CameraViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("finished picking image")
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as?  UIImage{
            selectedImage = image
            photo.image = image
            dismiss(animated: true, completion: nil)
        }
    }
}
