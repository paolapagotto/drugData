//
//  EsqueceuASenhaViewController.swift
//  DrugData
//
//  Created by Grazi Berti on 11/11/20.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKLoginKit
import FBSDKCoreKit

class EsqueceuASenhaViewController: UIViewController {

    @IBOutlet weak var labelPasswordText: UILabel!
    @IBOutlet weak var textFieldUserEmail: UITextField!
    @IBOutlet weak var buttonOutletSendEmail: UIButton!
    
    //MARK: IBAction
    @IBAction func buttonActionSendEmail(_ sender: Any) {
        Auth.auth().sendPasswordReset(withEmail: textFieldUserEmail.text!) {
            error in
          // ...
        }
        let alertController = UIAlertController(title: "Email enviado", message: "Enviamos um email para a configuração de uma nova senha", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Aceitar", style: .default))
        
        self.present(alertController, animated: true, completion: nil)
        cleanTextFields()
    }
    
    private func cleanTextFields() {
        textFieldUserEmail.text = ""
       }
    
    var text: String = "CASO ESTEJA CADASTRADO EM NOSSO SISTEMA, RECEBERA EM INSTANTES UM EMAIL PARA CONFIGURAR UMA NOVA SENHA."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelPasswordText.text = text
    }
    
    

}
