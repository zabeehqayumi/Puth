//
//  HomeViewController.swift
//  Puth
//
//  Created by Zabeehullah Qayumi on 9/28/18.
//  Copyright © 2018 Zabeehullah Qayumi. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseAuth
import Firebase
import FirebaseStorage
import SVProgressHUD
import Nuke

class HomeViewController: UIViewController {
    
    var arrOfData = [Model]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPosts()
        
        let nib = UINib(nibName: "HomeViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "HomeCell")
        
    }
        
    func loadPosts() {

        Database.database().reference().child("Posts").observe(.childAdded) { (DataSnapshot) in
            if let dict = DataSnapshot.value as? [String: Any] {
                
                
                let captionText = dict["caption"] as! String
                let photoUrl = dict["newPostUrl"] as! String
                
                let posts = Model(captionText: captionText, photoUrlString: photoUrl)
                self.arrOfData.append(posts)
                self.tableView.reloadData()
            }
        }
        
        
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

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrOfData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeViewCell
        
        cell.commentsLabel.text = arrOfData[indexPath.row].caption
        
        if let imageView = cell.postImage, let url = URL(string: arrOfData[indexPath.row].photoUrl!){
            Nuke.loadImage(
                with: url,
                options: ImageLoadingOptions(
                    placeholder: UIImage(named: "placeHolder"),
                    transition: .fadeIn(duration: 0.01)
                ),
                //
                into: imageView
            )
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
}

