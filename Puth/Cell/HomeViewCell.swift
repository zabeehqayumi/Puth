//
//  HomeViewCell.swift
//  Puth
//
//  Created by Zabeehullah Qayumi on 2/3/19.
//  Copyright © 2019 Zabeehullah Qayumi. All rights reserved.
//

import UIKit

protocol HomeViewCellDelegate: class {
    func updateMainScreen(_ sender: HomeViewCell)
}

class HomeViewCell: UITableViewCell, UIScrollViewDelegate, UINavigationControllerDelegate {
    
    weak var delegete: HomeViewCellDelegate?

    @IBOutlet weak var separatorHeight: NSLayoutConstraint!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var likeLabel: UIButton!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var isLiked : Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        sepratorLine()
        setupProfile()
        likeLabel.layer.cornerRadius = 5
        likeLabel.layer.borderWidth = 1.0
        likeLabel.layer.borderColor = UIColor.lightGray.cgColor
        self.selectionStyle = .none
        
        let rotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(self.rotationGesture))
        profilePicture.addGestureRecognizer(rotationGesture)
        
    }
    
    func setupProfile() {

        profilePicture.layer.cornerRadius = 12
        profilePicture.clipsToBounds = true
        nameLabel.text = "dummy_name"
        nameLabel.adjustsFontSizeToFitWidth = true
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return profilePicture
    }
    
    @objc func rotationGesture(sender: UIRotationGestureRecognizer){
        sender.view?.transform = (sender.view?.transform)!.rotated(by: sender.rotation)
        sender.rotation = 0
        
    }

    
    @IBAction func likedButtonTapped(_ sender: Any) {
        
        if isLiked == false {
            likeLabel.setTitle("Liked", for: UIControl.State.normal)
            likeLabel.backgroundColor = UIColor.lightGray
            likeLabel.tintColor = UIColor.black
        } 
        
    }
    
    func sepratorLine() {
        separatorView.backgroundColor = UIColor.lightGray
        separatorHeight.constant = 10.0
        
    }
    
    @IBAction func ellipsesButtonTapped(_ sender: Any) {
        delegete?.updateMainScreen(self)
    }
}

