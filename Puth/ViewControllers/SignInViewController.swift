//
//  SignInViewController.swift
//  Puth
//
//  Created by Zabeehullah Qayumi on 9/26/18.
//  Copyright © 2018 Zabeehullah Qayumi. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseStorage
import SVProgressHUD


class SignInViewController: UIViewController {
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Designing the email textfield
        emailTextField.backgroundColor = .black
        emailTextField.tintColor = .white
        emailTextField.attributedPlaceholder = NSAttributedString(string: emailTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: UIColor(white: 1.0, alpha: 0.6)])
        
        let bottomLayer = CALayer()
        bottomLayer.frame = CGRect(x: 0, y: 29, width: 340, height: 0.7)
        bottomLayer.backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 25/255, alpha: 1).cgColor
        emailTextField.layer.addSublayer(bottomLayer)
        
        //Designing the password field
        
        passwordTextField.backgroundColor = .black
        passwordTextField.tintColor = .white
        passwordTextField.attributedPlaceholder = NSAttributedString(string: passwordTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: UIColor(white: 1.0, alpha: 0.6)])
        
        let bottomLayer1 = CALayer()
        bottomLayer1.frame = CGRect(x: 0, y: 29, width: 340, height: 0.7)
        bottomLayer1.backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 25/255, alpha: 1).cgColor
        passwordTextField.layer.addSublayer(bottomLayer1)
        
        
        // calling
        
        handleTextField()
        

    }
    
    
    func handleTextField(){
        emailTextField.addTarget(self, action: #selector(SignUPViewController.textFieldDidChange), for: UIControl.Event.editingChanged)
        passwordTextField.addTarget(self, action: #selector(SignUPViewController.textFieldDidChange), for: UIControl.Event.editingChanged)
        
    }
    
    @objc
    func textFieldDidChange(){
        
        guard let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty else {
            signInButton.setTitleColor(UIColor.lightText, for: UIControl.State.normal)
            signInButton.isEnabled = false
            return
        }
        signInButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        signInButton.isEnabled = true
        
        
        
        
    }
    
    
    func notifyUser(){
        let alert = UIAlertController(title: "Invalid Username or Password!", message: "email or password you entered does not match our database. ", preferredStyle: .alert)
        let action = UIAlertAction(title: "Try again", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    

    
    
    @IBAction func signInButtonPressed(_ sender: Any) {
        SVProgressHUD.show()
        
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if error != nil{
                SVProgressHUD.dismiss()
                self.notifyUser()
                
                return
            }else{
                // navigating to
                self.performSegue(withIdentifier: "navigatetoTabbedVC", sender: nil)
                SVProgressHUD.dismiss()
            }
            
 
            
            
        }
    }
    
    // Auto log in
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil{
        self.performSegue(withIdentifier: "navigatetoTabbedVC", sender: nil)

        }
        
    }

}
