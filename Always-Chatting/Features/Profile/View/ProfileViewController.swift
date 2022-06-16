//
//  ProfileViewController.swift
//  Always-Chatting
//
//  Created by Fernando Tello on 16/04/22.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profilePhoto: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var fullnameLabel: UILabel!
    
    
    @IBOutlet weak var photoCount: UILabel!
    @IBOutlet weak var followerCount: UILabel!
    @IBOutlet weak var followingCount: UILabel!
    
    @IBOutlet weak var uiViewShadow: UIView!
    
    private var profileViewModel: ProfileViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        loadProfileInfo()
    }
    
    
    @IBAction func logOutBtnPressed(_ sender: UIButton) {
        logOut(sender)
    }
    
    
    // MARK: - Private
    private func setupViews() {
        
        profilePhoto.layer.borderWidth = 0.5
        profilePhoto.layer.masksToBounds = false
        //        profilePhoto.layer.borderColor = UIColor.black.cgColor
        profilePhoto.layer.cornerRadius = profilePhoto.frame.height/2
        profilePhoto.clipsToBounds = true
        
        // corner radius
        uiViewShadow.layer.cornerRadius = 10
        
        // border
        uiViewShadow.layer.borderWidth = 1.0
        uiViewShadow.layer.borderColor = UIColor.black.cgColor
        uiViewShadow.backgroundColor = UIColor(named: "red")
        
        // shadow
        uiViewShadow.layer.shadowColor = UIColor.black.cgColor
        uiViewShadow.layer.shadowOffset = CGSize(width: 3, height: 3)
        uiViewShadow.layer.shadowOpacity = 0.7
        uiViewShadow.layer.shadowRadius = 4.0
        
        // Do any additional setup after loading the view.
    }
}

// MARK: - Functions
extension ProfileViewController {
    
    func loadProfilePhoto() {
        //        profileViewModel.loadProfilePhoto()
    }
    
    func loadProfileInfo() {
        //        profileViewModel.loadProfileInfo()
        
        descriptionLabel.text = profileViewModel.description
        fullnameLabel.text = profileViewModel.fullname
        followingCount.text = profileViewModel.followingCount
        photoCount.text = profileViewModel.photoCount
        followerCount.text = profileViewModel.followerCount
    }
    
    func logOut(_ sender: UIButton) {
        //        profileViewModel.logout()
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
