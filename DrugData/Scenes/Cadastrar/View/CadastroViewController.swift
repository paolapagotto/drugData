//
//  CadastroViewController.swift
//  DrugData
//
//  Created by Grazi Berti on 11/11/20.
//

import UIKit

import FirebaseAuth


class CadastroViewController: UIViewController, ImagePickerFotoSelecionada {

    // MARK: IBOutlet 
    @IBOutlet weak var imageViewUser: UIImageView!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var textFiedConfirmPassword: UITextField!
    
    // MARK: Atributos
    let imagePicker = ImagePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cornerRadiuView()
        self.setup()
//        isValidEmail(textFieldEmail.text!)
//        isValidPassword(textFieldPassword.text!)
        textFieldEmail.text = ""
        textFieldPassword.text = ""
        
    }
   // MARK: IBAction
    @IBAction func buttonNextRegister(_ sender: Any) {
        if let tabBarController = UIStoryboard(name: "PesquisarViewController", bundle: nil).instantiateViewController(withIdentifier: "tabBarController") as? UITabBarController{
            getUser(email: textFieldEmail.text!, password: textFieldPassword.text!)
            isLogged()
            UIViewController.replaceRootViewController(viewController: tabBarController)
        }
    }
    
    @IBAction func buttonPicture(_ sender: Any) {
        
        let menu = ImagePicker().menuDeOpcoes(completion: {
            (opcao) in self.mostraMultimidia(opcao: opcao)
        })
        present(menu, animated: true, completion: nil)
    }
    
    // MARK: Métodos
    func mostraMultimidia(opcao: MenuDeOpcoes) {
        let multimidia = UIImagePickerController()
        multimidia.delegate = imagePicker as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
        
        if opcao == .camera && UIImagePickerController.isSourceTypeAvailable(.camera) {
            multimidia.sourceType = .camera
        }
        
        else {
            multimidia.sourceType = .photoLibrary
        }
        self.present(multimidia, animated: true, completion: nil)
    }
    
    // MARK: Delegate
    func imagePickerFotoSelecionada(_ foto: UIImage) {
        imageViewUser.image = foto
    }
    
    func setup() {
        imagePicker.delegate = self
    }
    func cornerRadiuView() {
        imageViewUser.layer.cornerRadius = imageViewUser.frame.width / 2
        imageViewUser.layer.borderWidth = 0.5
       // imageViewUser . layer.borderWidth = UIColor.lightGray.cgColor
    }
    
    // MARK: Firebase
    let email = "example@gmail.com"
    let password = "testtest"
    
    func createUser(_ email: String,_ password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
          if let error = error as? NSError {
            switch AuthErrorCode(rawValue: error.code) {
            case .operationNotAllowed: break
              // Error: The given sign-in provider is disabled for this Firebase project. Enable it in the Firebase console, under the sign-in method tab of the Auth section.
            case .emailAlreadyInUse: break
              // Error: The email address is already in use by another account.
            case .invalidEmail: break
              // Error: The email address is badly formatted.
            case .weakPassword: break
              // Error: The password must be 6 characters long or more.
            default:
                print("Error: \(error.localizedDescription)")
            }
          } else {
            print("User signs up successfully")
            let newUserInfo = Auth.auth().currentUser
            let email = newUserInfo?.email
          }
        }
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
      }
      func isValidPassword(_ password: String) -> Bool {
        let minPasswordLength = 6
        return password.count >= minPasswordLength
      }
    
    func getUser(email: String!, password: String!) {
        if (isValidEmail(textFieldEmail.text!) && isValidPassword(textFieldPassword.text!)){
            textFieldEmail.text = email
            textFieldPassword.text = password
            
            createUser(email, password)
        }
         
    }
    
     func isLogged() -> Bool {
            return Auth.auth().currentUser != nil
    }
    
}
