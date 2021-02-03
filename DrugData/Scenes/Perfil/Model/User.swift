//
//  User.swift
//  DrugData
//
//  Created by Pagotto on 03/02/21.
//

import Foundation
import Foundation
import Firebase
import GoogleSignIn

protocol AddUser {
    func getUserEmail()
}

class User: AddUser {
    var name: String
    var phone: String
    var email:String
    var password:String
    init(name: String, phone: String, email:String, password:String) {
        self.name = name
        self.phone = phone
        self.email = email
        self.password = password
    }
    
    func newUser(user: User){
        setUser(user: user)
    }
    
    func setUser(user: User){
        self.name = user.name
        self.email = user.email
        self.phone = user.phone
        self.password = user.password
        
    }
    
    func getUserEmail(){
        print("User \(self.email)")
    }
}

class UserData {
    private var userList = [AddUser]()

    func addUserToList(user: AddUser) {
        userList.append(user)
    }
    func printUserList() {
        for user in userList{
            print(user)
        }
    }
    private func userCard(user: AddUser){
        user.getUserEmail()
    }
}
