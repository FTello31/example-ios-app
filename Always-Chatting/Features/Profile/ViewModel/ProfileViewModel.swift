//
//  ProfileViewModel.swift
//  Always-Chatting
//
//  Created by Fernando Tello on 14/06/22.
//

import Foundation
import Firebase

protocol ProfileViewModelInput {
    func loadProfilePhoto()
    func loadProfileInfo()
    func logout()
}

protocol ProfileViewModelOutput {
    //    var profilePhoto: UIImageView
    var description: String { get }
    var fullname: String { get }
    var photoCount: String { get }
    var followerCount: String { get }
    var followingCount: String { get }
}

protocol ProfileViewModel: ProfileViewModelInput,ProfileViewModelOutput {}

final class DefaultProfileViewModel:ProfileViewModel {

    // MARK: - OUTPUT
    let description: String
    let fullname: String
    let photoCount: String
    let followerCount: String
    let followingCount: String
    
    let db = Firestore.firestore()
    let storage = Storage.storage()
    //    storage = Storage.storage(url:"gs://always-chatting.appspot.com")
    
    var photoPath:String = ""
    
    init(profile: Profile) {
        self.description = profile.description ?? ""
        self.fullname = profile.fullname ?? ""
        self.photoCount = profile.photoCount ?? ""
        self.followerCount = profile.followerCount ?? ""
        self.followingCount = profile.followingCount ?? ""
    }
}

// MARK: - INPUT. View event methods
extension DefaultProfileViewModel {
    func loadProfilePhoto() {
        
        let pathReference = storage.reference(withPath: photoPath)
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
    
    func loadProfileInfo() {
        
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
    
    func logout() {
        
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
}

