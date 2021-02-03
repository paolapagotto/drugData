//
//  CadastroViewController.swift
//  DrugData
//
//  Created by Grazi Berti on 11/11/20.
//

import UIKit

import FirebaseAuth




class CadastroViewController: UIViewController, ImagePickerFotoSelecionada, UITextFieldDelegate{

    // MARK: IBOutlet 
    @IBOutlet weak var imageViewUser: UIImageView!
    
    @IBOutlet weak var textFieldUserName: UITextField!
    @IBOutlet weak var textFieldUserPhone: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var textFiedConfirmPassword: UITextField!
    @IBOutlet weak var buttonNextRegister: UIButton!
    
    // MARK: Atributos
    let imagePicker = ImagePicker()
    var user: User?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cornerRadiusView()
        self.setup()
        user = User(name: textFieldUserName.text!, phone: textFieldUserPhone.text!, email: textFieldEmail.text!, password: textFieldPassword.text!)
        textFieldEmail.delegate = self
        textFieldPassword.delegate = self
        
    }
    
    private func cleanTextFields() {
        textFieldUserName.text = ""
        textFieldUserPhone.text = ""
        textFieldEmail.text = ""
        textFieldPassword.text = ""
        textFiedConfirmPassword.text = ""
        }
    
   // MARK: IBAction
    @IBAction func buttonNextRegister(_ sender: Any) {
            
        if let email = textFieldEmail.text, let password = textFieldPassword.text {
            if validateInfo(){
                Auth.auth().createUser(withEmail: email, password: password) { [self] (result, error) in
                    if let result = result, error == nil {
                        if let loginView = UIStoryboard(name: "LoginViewController", bundle: nil).instantiateInitialViewController() as? LoginViewController {
                            navigationController?.pushViewController(loginView, animated: true)
                        }
                    }
                    
                    return cleanTextFields()
                }
            } else {
                let alertController = UIAlertController(title: "Error", message: "Email ou Senha inválidos", preferredStyle: .alert)
                
                alertController.addAction(UIAlertAction(title: "Aceitar", style: .default))
                
                self.present(alertController, animated: true, completion: nil)
                return cleanTextFields()
            }
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
    func cornerRadiusView() {
        imageViewUser.layer.cornerRadius = imageViewUser.frame.width / 2
        imageViewUser.layer.borderWidth = 0.5
       // imageViewUser . layer.borderWidth = UIColor.lightGray.cgColor
    }
    
    // MARK: Firebase

    func isValidEmail(_ email: String) -> Bool {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z.]{2,64}"
            
            let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailPred.evaluate(with: email)
        }
        
    func isValidPassword(_ password: String) -> Bool {
            let passwordRegEx = "[A-Za-z0-9]{6,12}"

            let passwordPred = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
            return passwordPred.evaluate(with: password)
        }
    
    func validateInfo() -> Bool {
        let user = User(name: textFieldUserName.text!, phone: textFieldUserPhone.text!, email: textFieldEmail.text!, password: textFieldPassword.text!)
            if !isValidEmail(textFieldEmail.text!)
                {
                    print("Valid e-mail is required!")
                    return false
                }
            if !isValidPassword(textFieldPassword.text!)
                {
                    print("Password is required!")
                    return false
                }
            if  textFiedConfirmPassword.text != textFieldPassword.text {
                print("Password doesn't match")
                return false
            }
            print("Usuário cadastrado!")
            buttonNextRegister.isEnabled = true
            user.email = textFieldEmail.text ?? "email inválido"
            user.setUser(user: user)
            
        
            return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            if textField == textFieldEmail {
                textFieldPassword.becomeFirstResponder()
            } else {
                if validateInfo() {
                    textField.resignFirstResponder()
                }
            }
            return true
        }
         
     func isLogged() -> Bool {
            return Auth.auth().currentUser != nil
    }
}


