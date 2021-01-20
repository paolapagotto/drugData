//
//  LoginViewController.swift
//  DrugData
//
//  Created by Grazi Berti on 11/11/20.
//

import UIKit
import Firebase
import GoogleSignIn


class LoginViewController: UIViewController {
    
    // MARK: @IBOutlet
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var signInButton: GIDSignInButton!
    
    @IBAction func buttonForgotPassword(_ sender: Any) {
        if let forgotPassword = UIStoryboard(name: "EsqueceuASenhaViewController", bundle: nil).instantiateInitialViewController() as? EsqueceuASenhaViewController {
            navigationController?.pushViewController(forgotPassword, animated: true)
        }
    }
    @IBAction func buttonLoggin(_ sender: Any) {
        if let tabBarController = UIStoryboard(name: "PesquisarViewController", bundle: nil).instantiateViewController(withIdentifier: "tabBarController") as? UITabBarController{
            UIViewController.replaceRootViewController(viewController: tabBarController)
        }
    }
    
    @IBAction func buttonEmail(_ sender: Any) {
    }
    @IBAction func buttonPassword(_ sender: Any) {
    }
    
//    @IBAction func buttonLoginGoogle(_ sender: Any) {
//        
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().signIn()
        
    }
    
    
    // MARK: Métodos
//    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
//        
//        print("User email: \(user.profile.email ?? "No Email")")
//        if let error = error {
//            print("\(error)")
//            return
//          }
//
//          guard let authentication = user.authentication else { return }
//          let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
//                                                            accessToken: authentication.accessToken)
//        
//        
//        Auth.auth().signIn(with: credential) { (authResult, error) in
//          if let error = error {
//            let authError = error as NSError
//
//            // ...
//            return
//          }
//          // User is signed in
//      
//           
//            
//        }
//        
//       
//    }
    
   
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
