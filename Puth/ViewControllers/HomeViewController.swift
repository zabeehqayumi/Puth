//
//  HomeViewController.swift
//  Puth
//
//  Created by Zabeehullah Qayumi on 9/28/18.
//  Copyright © 2018 Zabeehullah Qayumi. All rights reserved.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    @IBAction func logOutButtonPressed(_ sender: Any) {
        
        do{
            try Auth.auth().signOut()
        }catch{
            print(error.localizedDescription)
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let signInVC = storyboard.instantiateViewController(withIdentifier: "SignInViewController")
        self.present(signInVC, animated: true, completion: nil)
        
        
        
    }
}

