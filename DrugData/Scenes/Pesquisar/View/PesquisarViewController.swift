//
//  PesquisarViewController.swift
//  DrugData
//
//  Created by Grazi Berti on 12/11/20.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKLoginKit
import FBSDKCoreKit
import FacebookLogin


class PesquisarViewController: UIViewController, UISearchBarDelegate {

    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelLocation: UILabel!
    @IBOutlet weak var imageViewAvatar: UIImageView!
    @IBOutlet weak var searchbarByName: UISearchBar!
    @IBOutlet weak var searchbarByLaboratory: UISearchBar!
    @IBOutlet weak var searchbarBySubstance: UISearchBar!
    
    var arrayRemedios = [Remedio] ()
    var filteredRemedios = [Remedio] ()
    var resultadoPesquisaViewModel: ResultadoPesquisaViewModel?
    var resultadoPesquisaViewController: ResultadoPesquisaViewController?
    //private let provider: ProviderType
    
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
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cornerRadiusView()
        userFirebase()
        resultadoPesquisaViewModel = ResultadoPesquisaViewModel()
        resultadoPesquisaViewController = ResultadoPesquisaViewController()
        searchbarByName.delegate = self
        searchbarByLaboratory.delegate = self
        searchbarBySubstance.delegate = self
        resultadoPesquisaViewModel?.filteredRemedios = resultadoPesquisaViewModel!.arrayRemedios
    }
    @IBAction func buttonSearchMedice(_ sender: Any) {
      //if !filteredRemedios.isEmpty {
//
//            resultadoPesquisaViewController?.tableViewResult.reloadData()
            if let search = UIStoryboard(name: "ResultadoPesquisaViewController", bundle: nil).instantiateInitialViewController() as? ResultadoPesquisaViewController{
                navigationController?.pushViewController(search, animated: true)
            }
        
        
        
        
    }
    
}

    
