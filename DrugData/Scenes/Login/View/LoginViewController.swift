//
//  LoginViewController.swift
//  DrugData
//
//  Created by Grazi Berti on 11/11/20.
//

import UIKit
import Firebase
import GoogleSignIn


class LoginViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: @IBOutlet
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var signInButton: GIDSignInButton!
<<<<<<< HEAD
=======

    @IBOutlet weak var signInbuttonFB: FBSDKLoginButton!
>>>>>>> main
    
    @IBOutlet weak var FBLoginView: UIView!
    
    @IBOutlet weak var loginButton: FBLoginButton!
    
<<<<<<< HEAD
=======
    let signInButtonFB = FBLoginButton

>>>>>>> main
    
    @IBAction func buttonForgotPassword(_ sender: Any) {
        if let forgotPassword = UIStoryboard(name: "EsqueceuASenhaViewController", bundle: nil).instantiateInitialViewController() as? EsqueceuASenhaViewController {
            navigationController?.pushViewController(forgotPassword, animated: true)
        }
    }
    @IBAction func buttonLoggin(_ sender: Any) {
        
        if let email = textFieldEmail.text, let password = textFieldPassword.text {
            
            Auth.auth().signIn(withEmail: email, password: password) { [self] (result, error) in
                    if let result = result, error == nil {
                        if let tabBarController = UIStoryboard(name: "PesquisarViewController", bundle: nil).instantiateViewController(withIdentifier: "tabBarController") as? UITabBarController{
                                        UIViewController.replaceRootViewController(viewController: tabBarController)
                            
                        }
                    }else{
                        let alertController = UIAlertController(title: "Error", message: "Email ou Senha inválidos", preferredStyle: .alert)
                        
                        alertController.addAction(UIAlertAction(title: "Aceitar", style: .default))
                        
                        self.present(alertController, animated: true, completion: nil)
                    
                    
                    }
                    cleanTextFields()
                }
            }
    }
    
    private func cleanTextFields() {
        textFieldEmail.text = ""
        textFieldPassword.text = ""
        textFieldEmail.delegate = self
        textFieldPassword.delegate = self
       }
    
    func isLogged() -> Bool {
            return Auth.auth().currentUser != nil
    }
    
    func facebookIsLogged() {
        if let token = AccessToken.current,
                !token.isExpired {
                // User is logged in, do work such as go to next view controller.
            if let tabBarController = UIStoryboard(name: "PesquisarViewController", bundle: nil).instantiateViewController(withIdentifier: "tabBarController") as? UITabBarController{
                            UIViewController.replaceRootViewController(viewController: tabBarController)
            }
        }
        
    }
    
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
            let user = User(email: textFieldEmail.text!,
                            password: textFieldPassword.text!)
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
            user.email = textFieldEmail.text ?? "email inválido"
            print(user.email)
            
        
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().signIn()
<<<<<<< HEAD
        
        let loginButton = FBLoginButton()
        loginButton.permissions = ["public_profile", "email"]
        let newCenter = CGPoint(x: self.FBLoginView.frame.width / 2, y: self.FBLoginView.frame.height / 2)
        loginButton.center = newCenter
        self.FBLoginView.addSubview(loginButton)
        
        //facebookIsLogged()
=======

        signInButtonFB.center = view.center
        
>>>>>>> main
    }
   
}

extension UIViewController {
    class func replaceRootViewController(viewController: UIViewController) {
        guard let window = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first
        else {
            return
        }
        let rootViewController = window.rootViewController!

        viewController.view.frame = rootViewController.view.frame
        viewController.view.layoutIfNeeded()

        UIView.transition(with: window, duration: 0.3, options: .transitionFlipFromLeft, animations: {
            window.rootViewController = viewController
        }, completion: nil)
    }
}


