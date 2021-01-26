//
//  ViewController.swift
//  DrugData
//
//  Created by Grazi Berti on 09/11/20.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Outlet
    
    
   
    @IBOutlet weak var imageViewLogo: UIImageView!
    
    
    @IBAction func buttonLogin(_ sender: Any) {
        if let loginView = UIStoryboard(name: "LoginViewController", bundle: nil).instantiateInitialViewController() as? LoginViewController {
            navigationController?.pushViewController(loginView, animated: true)
        }
    }
    
    @IBAction func buttonRegister(_ sender: Any) {
        
        if let registerView = UIStoryboard(name: "CadastroViewController", bundle: nil).instantiateInitialViewController() as? CadastroViewController {
            
            navigationController?.pushViewController(registerView, animated: true)
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageViewLogo.image = UIImage(named: "pills09.png")
    }


}

@IBDesignable extension UIButton {
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}
