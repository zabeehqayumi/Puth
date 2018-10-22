//
//  AuthServices.swift
//  Puth
//
//  Created by Zabeehullah Qayumi on 10/21/18.
//  Copyright © 2018 Zabeehullah Qayumi. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseStorage
import SVProgressHUD


class AuthServices: UIViewController {
    
  //  static var shared = AuthServices()
    
    
 // sign in method
    
    static func signIn(email: String, password: String, onSuccess: @escaping () -> Void, onError: @escaping () -> Void) {
        SVProgressHUD.show()
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil{
                onError()
                print(error!.localizedDescription)
                return
            }
            onSuccess()
            SVProgressHUD.dismiss()
        }
    }
    
    
   // sign up method
    
    
    
    static func signUp(username: String, email: String, password: String, onSuccess: @escaping () -> Void, onError: @escaping () -> Void) {
        SVProgressHUD.show()
        
        // do some stuff here

            SVProgressHUD.dismiss()
        }
    
    
    
    
    
}
