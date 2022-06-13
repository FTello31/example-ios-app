//
//  ProfileViewController.swift
//  Always-Chatting
//
//  Created by Fernando Tello on 16/04/22.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profilePhoto: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var fullnameLabel: UILabel!
    
    
    @IBOutlet weak var photoCount: UILabel!
    @IBOutlet weak var followerCount: UILabel!
    @IBOutlet weak var followingCount: UILabel!
    
    @IBOutlet weak var uiViewShadow: UIView!
    
    var photoPath:String = ""
    
    let db = Firestore.firestore()
    let storage = Storage.storage()
    //    storage = Storage.storage(url:"gs://always-chatting.appspot.com")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        loadProfileInfo()
    }
    
    
    @IBAction func LogOutBtnPressed(_ sender: UIButton) {
        logOut(sender)
    }

}


// MARK: - Functions
extension ProfileViewController {
    
    func loadProfilePhoto(){
        let pathReference = storage.reference(withPath: photoPath)
        print("******pathReference******* \(pathReference)")
        // Create a reference to the file you want to download
        //        let islandRef = pathReference.child(photoPath)
        
        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
        pathReference.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                // Uh-oh, an error occurred!
                print("Error \(error)")
            } else {
                // Data for "images/island.jpg" is returned
                let image = UIImage(data: data!)
                DispatchQueue.main.async {
                    self.profilePhoto.image = image
                }
            }
        }
    }
    
    func loadProfileInfo(){
        
        let docRef = db.collection("Users").document("yacM4GRjIFKXfEJRuUaz")
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                if let dataDescription = document.data() {
                    // let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                    print("******** Document data: \(dataDescription) *********")
                    
                    self.photoPath = dataDescription["path"] as? String ?? ""
                    self.loadProfilePhoto()
                    
                    DispatchQueue.main.async {
                        
                        self.descriptionLabel.text = dataDescription["description"]  as? String ?? ""
                        self.fullnameLabel.text = dataDescription["name"] as? String ?? ""
                        self.followingCount.text = dataDescription["followings"] as? String ?? "0"
                        self.photoCount.text = dataDescription["quantityPhotos"] as? String ?? "0"
                        self.followerCount.text = dataDescription["followers"] as? String ?? "0"
                        
                    }
                }
                
            } else {
                print("Document does not exist")
            }
        }
    }
    
    func logOut(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginNavController = storyboard.instantiateViewController(identifier: "LoginNavigationController")

        do {
            try Auth.auth().signOut()
            //            navigationController?.popToRootViewController(animated: true)
            
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(loginNavController)
            
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
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
