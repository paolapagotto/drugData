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

class PerfilViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var imageViewUserProfilePhoto: UIImageView!
    @IBOutlet weak var textFieldUserName: UITextField!
    @IBOutlet weak var textFieldUserPhone: UITextField!
    @IBOutlet weak var textFieldUserEmail: UITextField!
    
    @IBOutlet weak var textFieldUserPassword: UITextField!
    
    @IBOutlet weak var buttonUIEditUserProfile: UIButton!
    @IBOutlet weak var buttonLogOut: UIButton!
    
    var user: User?
    
    @IBAction func buttonActionEditUserProfile(_ sender: Any) {
        let user = User(name: textFieldUserName.text!, phone: textFieldUserPhone.text!, email: textFieldUserEmail.text!, password: textFieldUserPassword.text!)
                user.name = textFieldUserName.text!
                user.email = textFieldUserEmail.text!
                user.phone = textFieldUserPhone.text!
                user.password = textFieldUserPassword.text!
                user.setUser(user: user)
    }
    
    @IBAction func buttonLogOut(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            if let loginView = UIStoryboard(name: "LoginViewController", bundle: nil).instantiateInitialViewController() as? LoginViewController {
                navigationController?.pushViewController(loginView, animated: true)
            }
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
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
          let photoURL = user.photoURL
        
        }
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
//        changeRequest?.displayName = displayName
        changeRequest?.commitChanges { (error) in
          // ...
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFieldUserName.delegate = self
        textFieldUserPhone.delegate = self
        textFieldUserEmail.delegate = self
        textFieldUserPassword.delegate = self
        textFieldUserName.placeholder = user?.name
        textFieldUserPhone.placeholder = user?.phone
        textFieldUserEmail.placeholder = user?.email
        textFieldUserPassword.placeholder = user?.password
        buttonUIEditUserProfile.isEnabled = false
        
    }
}

extension PerfilViewController {
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool{
        
        buttonUIEditUserProfile.isEnabled = true
        return true
    }
    
    
}
