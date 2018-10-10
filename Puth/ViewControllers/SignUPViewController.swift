//
//  SignUPViewController.swift
//  Puth
//
//  Created by Zabeehullah Qayumi on 9/26/18.
//  Copyright © 2018 Zabeehullah Qayumi. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUPViewController: UIViewController {

    
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Profile Picture
        profilePicture.layer.cornerRadius = 40 
        profilePicture.clipsToBounds = true
        
        //Username
        userNameTextField.backgroundColor = .black
        userNameTextField.tintColor = .white
        userNameTextField.textColor = .white
        userNameTextField.attributedPlaceholder = NSAttributedString(string: userNameTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: UIColor(white: 1.0, alpha: 0.6)])
        
        let bottomLayerUserName = CALayer()
        bottomLayerUserName.frame = CGRect(x: 0, y: 29, width: 340, height: 0.7)
        bottomLayerUserName.backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 25/255, alpha: 1).cgColor
        userNameTextField.layer.addSublayer(bottomLayerUserName)
        
        
        //Email
        emailTextField.backgroundColor = .black
        emailTextField.tintColor = .white
        emailTextField.textColor = .white
        emailTextField.attributedPlaceholder = NSAttributedString(string: emailTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: UIColor(white: 1.0, alpha: 0.6)])
        
        let bottomLayer = CALayer()
        bottomLayer.frame = CGRect(x: 0, y: 29, width: 340, height: 0.7)
        bottomLayer.backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 25/255, alpha: 1).cgColor
        emailTextField.layer.addSublayer(bottomLayer)
        
        //Password
        
        passwordTextField.backgroundColor = .black
        passwordTextField.tintColor = .white
        passwordTextField.textColor = .white
        passwordTextField.attributedPlaceholder = NSAttributedString(string: passwordTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: UIColor(white: 1.0, alpha: 0.6)])
        
        let bottomLayerPass = CALayer()
        bottomLayerPass.frame = CGRect(x: 0, y: 29, width: 340, height: 0.7)
        bottomLayerPass.backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 25/255, alpha: 1).cgColor
        passwordTextField.layer.addSublayer(bottomLayerPass)
        
        
        // Uploading image
        
    
       let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SignUPViewController.handleSelectProfileImage))
        profilePicture.addGestureRecognizer(tapGesture)
        profilePicture.isUserInteractionEnabled = true
        


    }
    
   @objc func handleSelectProfileImage(){
    let pickerController = UIImagePickerController()
    present(pickerController, animated: true, completion: nil)
    
    }
    
    @IBAction func dismiss_OnClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
        
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) {
            (user, error) in
            if error != nil{
                print(error!)
            }
            else{
                
                // creating username and email address in database realtime of firebase
                
                let ref = Database.database().reference()
                let userReference = ref.child("users").child((user?.user.uid)!)
                
                userReference.setValue(["username": self.userNameTextField.text!, "email": self.emailTextField.text!])
              
            }
    
            }
        
    
    }
    

}
