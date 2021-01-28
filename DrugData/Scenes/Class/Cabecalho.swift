//
//  Cabecalho.swift
//  DrugData
//
//  Created by Grazi Berti on 18/11/20.
//

import Foundation
import Firebase
import GoogleSignIn

class Cabecalho {
    
    var name: String
    var email: String
    var phoneNumber: String
    var location: String
    var userImage: UIImage
    var photoURL: URL
    var uid: String
    
    init(name: String, email: String, location: String, photoURL: URL, userImage: UIImage, phoneNumber: String, uid: String) {
        self.name = name
        self.location = location
        self.photoURL = photoURL
        self.userImage = userImage
        self.email = email
        self.phoneNumber = phoneNumber
        self.location = location
        self.uid = uid
       
    }
    
    func userSetup(usuario: Cabecalho) {
        let handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
              // The user's ID, unique to the Firebase project.
              // Do NOT use this value to authenticate with your backend server,
              // if you have one. Use getTokenWithCompletion:completion: instead.

                let uid = user.uid
                let email = user.email
                let photoURL = user.photoURL
                let phoneNumber = user.phoneNumber
                let name = user.displayName
                
                let imagePicker = ImagePicker()
                imagePicker.delegate = usuario.userImage as! ImagePickerFotoSelecionada
                
                usuario.name = name ?? "User Name"
                usuario.email = email ?? "User Email"
                usuario.uid = uid
                usuario.location = ""
                usuario.phoneNumber = phoneNumber ?? ""
              }
        }
            
        
    }
    
    func isLogged() -> Bool {
            return Auth.auth().currentUser != nil
    }
    
    func viewWillAppear () {
        if isLogged(){
            let handle = Auth.auth().addStateDidChangeListener { (auth, user) in
                if let user = user {
                  // The user's ID, unique to the Firebase project.
                  // Do NOT use this value to authenticate with your backend server,
                  // if you have one. Use getTokenWithCompletion:completion: instead.
                    let uid = user.uid
                    let email = user.email
                    let photoURL = user.photoURL
                    let phoneNumber = user.phoneNumber
                    
                    
                }
             }
        }
        
    }

    func viewWillDisappear () {
            let handle = Auth.auth().addStateDidChangeListener { (auth, user) in
               // ...
             }
            Auth.auth().removeStateDidChangeListener(handle)
        
    }
    
}
