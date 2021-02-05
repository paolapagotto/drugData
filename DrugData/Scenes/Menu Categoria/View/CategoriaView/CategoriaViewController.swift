//
//  CategoriaViewController.swift
//  DrugData
//
//  Created by Grazi Berti on 18/11/20.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKLoginKit
import FBSDKCoreKit
import FacebookLogin

class CategoriaViewController: UIViewController {

    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelLocation: UILabel!
    @IBOutlet weak var imageViewAvatar: UIImageView!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cornerRadiusView()
        userFirebase()
      
    }
    func cornerRadiusView() {
        imageViewAvatar.layer.cornerRadius = imageViewAvatar.frame.width / 2
        imageViewAvatar.layer.borderWidth = 0.5
        //imageViewUserProfilePhoto.layer.borderWidth = UIColor.lightGray.cgColor
    }
    func userFirebase(){
        let user = Auth.auth().currentUser
        if let user = user {
          // The user's ID, unique to the Firebase project.
          // Do NOT use this value to authenticate with your backend server,
          // if you have one. Use getTokenWithCompletion:completion: instead.
          let uid = user.uid
          let name = user.displayName
            let photoURL = user.photoURL ?? URL(fileReferenceLiteralResourceName: "userplaceholder.png")
            labelName.text = name ?? "Olá"
            labelLocation.text = "São Paulo - SP"
            let data = try? Data(contentsOf: photoURL)
            if let imagedata = data {
                imageViewAvatar.image = UIImage(data: imagedata) ?? UIImage(named: "userplaceholder.png")
                cornerRadiusView()
            }
        }
    }

    @IBAction func buttonLaboratory(_ sender: Any) {
        if let filterLaboratory = UIStoryboard(name: "PesquisaLaboratorioViewController", bundle: nil).instantiateInitialViewController() as? PesquisaLaboratorioViewController {
            navigationController?.pushViewController(filterLaboratory, animated: true)
        }
    }
    
    @IBAction func buttonGeneric(_ sender: Any) {
        if let filterLaboratory = UIStoryboard(name: "GenericoViewController", bundle:
            nil).instantiateInitialViewController() as? GenericoViewController {
            navigationController?.pushViewController(filterLaboratory, animated: true)
        }
    }
    
    @IBAction func buttonControlMedice(_ sender: Any) {
        if let filterLaboratory = UIStoryboard(name: "ControladosViewController", bundle:
            nil).instantiateInitialViewController() as? ControladosViewController {
            navigationController?.pushViewController(filterLaboratory, animated: true)
        }
    }
    
    @IBAction func buttonOrganic(_ sender: Any) {
        if let filterLaboratory = UIStoryboard(name: "OrganicoViewController", bundle:
            nil).instantiateInitialViewController() as? OrganicoViewController {
            navigationController?.pushViewController(filterLaboratory, animated: true)
        }
    }
}
