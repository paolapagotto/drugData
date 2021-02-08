//
//  PerfilViewController.swift
//  DrugData
//
//  Created by Grazi Berti on 22/11/20.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKLoginKit
import FBSDKCoreKit
import FacebookLogin
import Foundation

class PerfilViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var imageViewUserProfilePhoto: UIImageView!
    @IBOutlet weak var textFieldUserName: UITextField!
    @IBOutlet weak var textFieldUserPhone: UITextField!
    @IBOutlet weak var textFieldUserEmail: UITextField!
    
    @IBOutlet weak var textFieldUserPassword: UITextField!
    
    @IBOutlet weak var buttonUIEditUserProfile: UIButton!
    @IBOutlet weak var buttonLogOut: UIButton!
    
    @IBOutlet weak var labelTeste: UILabel!
    var user: User?
    
    @IBAction func buttonActionEditUserProfile(_ sender: Any) {
        let user = User(name: textFieldUserName.text!, phone: textFieldUserPhone.text!, email: textFieldUserEmail.text!, password: textFieldUserPassword.text!)
                user.name = textFieldUserName.text!
                user.phone = textFieldUserPhone.text!
        
                updateUserLoginFirebase()
    }
    
    @IBAction func buttonLogOut(_ sender: Any) {
        
            do {
                try Auth.auth().signOut()
                let logout = LoginManager()
                logout.logOut()
                
                if let loginView = UIStoryboard(name: "LoginViewController", bundle: nil).instantiateInitialViewController() as? LoginViewController {
                    UIViewController.replaceRootViewController(viewController: loginView)
                }
            } catch let signOutError as NSError {
              print ("Error signing out: %@", signOutError)
            }
        
           
    }
    
    func isLogged() -> Bool {
            return Auth.auth().currentUser != nil
    }
    
    
    func updateUserLoginFirebase(){
        
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
//        changeRequest?.displayName = displayName
        changeRequest?.commitChanges { (error) in
          // ...
        }
        if textFieldShouldEndEditing(textFieldUserEmail){
            Auth.auth().currentUser?.updateEmail(to: textFieldUserEmail.text!) { (error) in
              // ...
            }
        }
        if textFieldShouldEndEditing(textFieldUserPassword){
            Auth.auth().currentUser?.updatePassword(to: textFieldUserPassword.text!) { (error) in
              // ...
            }
        }
    }
    //@IBOutlet weak var tableViewUser: UITableView!
    func userFirebase(){
        let user = Auth.auth().currentUser
        if let user = user {
          // The user's ID, unique to the Firebase project.
          // Do NOT use this value to authenticate with your backend server,
          // if you have one. Use getTokenWithCompletion:completion: instead.
          let uid = user.uid
          let name = user.displayName
          let phone = user.phoneNumber
          let email = user.email
            let photoURL = user.photoURL ?? URL(fileReferenceLiteralResourceName: "userplaceholder.png")
            textFieldUserName.placeholder = name
            textFieldUserPhone.placeholder = phone ?? "(xx)xxxxx-xxxx"
            textFieldUserEmail.placeholder = email
            let data = try? Data(contentsOf: photoURL)
            if let imagedata = data {
                imageViewUserProfilePhoto.image = UIImage(data: imagedata) ?? UIImage(named: "userplaceholder.png")
                cornerRadiusView()
            }
        }
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()

        changeRequest?.commitChanges { (error) in
          // ...
        }
    }
    
    func cornerRadiusView() {
        imageViewUserProfilePhoto.layer.cornerRadius = imageViewUserProfilePhoto.frame.width / 2
        imageViewUserProfilePhoto.layer.borderWidth = 0.5
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFieldUserName.delegate = self
        textFieldUserPhone.delegate = self
        textFieldUserEmail.delegate = self
        textFieldUserPassword.delegate = self
        buttonUIEditUserProfile.isEnabled = false
        buttonUIEditUserProfile.backgroundColor = UIColor.lightGray
        userFirebase()
        cornerRadiusView()
        
    }
}

extension PerfilViewController {
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool{
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField){
        buttonUIEditUserProfile.isEnabled = true
        buttonUIEditUserProfile.backgroundColor = UIColor(red: 193, green: 198, blue: 255)
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField){
        
    }
}
extension LoginButtonDelegate{
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        let logout = LoginManager()
        logout.logOut()
        
    }
}

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")
       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }
}

