//
//  CameraViewController.swift
//  Puth
//
//  Created by Zabeehullah Qayumi on 9/28/18.
//  Copyright © 2018 Zabeehullah Qayumi. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseStorage
import SVProgressHUD
import ImagePicker

class CameraViewController: UIViewController, UITextViewDelegate, ImagePickerDelegate {
    
    var selectedImage : UIImage?
    let photoID = NSUUID().uuidString

    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var captionTextView: UITextView!
    @IBOutlet weak var sharebutton: UIButton!
    
    @IBOutlet weak var removeButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        captionTextView.delegate = self
        captionTextView.text = "#write you comments ... "
        captionTextView.textColor = UIColor.lightGray
        
        gestureRecognizerForPic()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        checkPostPicture()
    }
    
    func gestureRecognizerForPic() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleSelectPhoto))
        photo.addGestureRecognizer(tapGesture)
        photo.isUserInteractionEnabled = true
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc func handleSelectPhoto() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        present(pickerController, animated: true, completion: nil)
        
    }
    
    @IBAction func shareButton(_ sender: Any) {
        pushImageToFireBase()
    }
    
    func pushImageToFireBase() {
        SVProgressHUD.show(withStatus: "Uploading")
        if let profileImage = self.selectedImage,
            let imageData = profileImage.jpegData(compressionQuality: 0.1) {
            self.uploadPhoto(imageData, photoID)
        }
        
    }
    
    
    @IBAction func cameraButtonTapped(_ sender: Any) {
        let imagePickerController = ImagePickerController()
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
        imagePickerController.imageLimit = 5

    }
    
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]){
        
    }
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]){
        
        guard let image = images.first else {
            dismiss(animated: true, completion: nil)
            return
        }
        selectedImage = image
        photo.image = image
        dismiss(animated: true, completion: nil)
        
        
    }
    func cancelButtonDidPress(_ imagePicker: ImagePickerController){
        
    }
    @IBAction func removeAllDataTapped(_ sender: Any) {
        selectedImage = nil
        captionTextView.text = ""
        photo.image = UIImage(named: "placeHolder")
        checkPostPicture()

    }
    
    func uploadPhoto(_ imageData: Data, _ userID: String) {
        
        // storing image to storage of firebase
    
        let storageRef = Storage.storage().reference(forURL: "gs://puth-d7c50.appspot.com").child("posted_image/\(photoID)")
        
          //now set up image data
        
        if let postedimage = self.selectedImage,
            let imageData = postedimage.jpegData(compressionQuality: 0.1) {
            self.putImageData(storageRef, imageData, { [weak self] (url, error) in
                print("## got URL response")
                if let postedImage = url?.absoluteString {
                    
                    // self?.globalUrl = profileImageURL
                    
                    let ref = Database.database().reference()
                    let newPostsReference = ref.child("Posts").child((self?.photoID)!)
                    newPostsReference.setValue(["newPostUrl": postedImage, "caption": self!.captionTextView.text!], withCompletionBlock: { (error, ref) in
                        if error != nil {
                            SVProgressHUD.showError(withStatus: error?.localizedDescription)
                            return
                        }
                        SVProgressHUD.showSuccess(withStatus: "Your image is uploaded successfully")
                        self?.captionTextView.text = ""
                        self?.photo.image = UIImage(named: "placeHolder")
                        self?.tabBarController?.selectedIndex = 0
                        self?.selectedImage = nil
                    })
                }
                
            })
        }
    }
    
    func putImageData(_ storageRef: StorageReference,
                      _ imageData: Data,
                      _ completion: @escaping (_ url: URL?, _ error: Error?) -> Void) {
        // storing image to storage of firebase
        storageRef.putData(imageData,
                           metadata: nil,
                           completion: { (metadata, error) in
                            // storing image to storage of firebase
                            print("## finished putData ")
                            storageRef.downloadURL(completion: completion)
        })
        
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


extension CameraViewController {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "#write you comments ... "
            textView.textColor = UIColor.lightGray
        }
    }
    
    func checkPostPicture() {
        if selectedImage != nil {
            self.sharebutton.isEnabled = true
            self.sharebutton.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            self.removeButton.isEnabled = true
        } else {
           self.sharebutton.isEnabled = false
            self.sharebutton.backgroundColor = UIColor.gray
            self.removeButton.isEnabled = false
        }
    }
    
    func notifyUser(){
        let alert = UIAlertController(title: "Select Image", message: "Please select Image you want to share", preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
