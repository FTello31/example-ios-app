//
//  LoginViewController.swift
//  Always-Chatting
//
//  Created by Fernando Tello on 29/03/22.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnLogingPressed(_ sender: UIButton) {
        login()
        
    }
}
// MARK: Functions
extension LoginViewController {
    
    func login() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")
        
        //        if let email = emailTextField.text , let password = passwordTextField.text {
        //            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
        //                if let e = error {
        //                    print(e)
        //                    self.showErrorMessage(e)
        //                } else {
        // This is to get the SceneDelegate object from your view controller
        // then call the change root view controller function to change to main tab bar
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
        //                }
        //            }
        //        }
    }
    
    func showErrorMessage(_ error:Error) {
        
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
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
