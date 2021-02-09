//
//  PesquisaLaboratorioViewController.swift
//  DrugData
//
//  Created by Grazi Berti on 16/11/20.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKLoginKit
import FBSDKCoreKit
import FacebookLogin

class PesquisaLaboratorioViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelLocation: UILabel!
    @IBOutlet weak var imageViewAvatar: UIImageView!
    @IBOutlet weak var searchBarLaboratory: UISearchBar!
    @IBOutlet weak var tableViewLaboratory: UITableView!
    @IBOutlet weak var activityIndicatorTableLoading: UIActivityIndicatorView!
    
    
    var arrayLaboratories = [String]()
    var searchLaboratories = [String]()
    var searching = false
    var categoriaViewModel: CategoriaViewModel?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoriaViewModel = CategoriaViewModel()
        cornerRadiusView()
        userFirebase()
      
        tableViewLaboratory.delegate = self
        tableViewLaboratory.dataSource = self
        
        searchBarLaboratory.delegate = self
        
        loadLaboratoryData()
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
    func loadLaboratoryData() {
        categoriaViewModel?.loadCategoryAPI(completion: {  (sucess, error) in
                   if sucess {
                       DispatchQueue.main.async {
                           self.tableViewLaboratory.reloadData()
                        self.activityIndicatorTableLoading.stopAnimating()
                        self.activityIndicatorTableLoading.hidesWhenStopped = true
                       }
                   }
        })
    }
    

}
extension PesquisaLaboratorioViewController: UITableViewDelegate{
    
}
extension PesquisaLaboratorioViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let allLabs = categoriaViewModel?.numberOfRowsLaboratorios() {
//            if searching {
//                return searchLaboratories.count
//            }
            return allLabs
        }
                return 0
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LaboratorioTableViewCell", for: indexPath) as! LaboratorioTableViewCell
        var a = Array(categoriaViewModel!.hashRemedios).count
        print(a)
        cell.setup(name: Array(categoriaViewModel!.hashRemedios.keys)[indexPath.row])
        return cell
        
    }
}

extension PesquisaLaboratorioViewController {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            print(searchBarLaboratory.text ?? "Laboratório não encontrado")
        }
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText:String){
//            searchLaboratories = categoriaViewModel!.hashRemedios.keys.filter({
//                $0.categoriaViewModel!.hashRemedios.keys.contains(searchText)
//            })
//            searching = true
//            tableViewLaboratory.reloadData()
//    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searching = false
            
            return tableViewLaboratory.reloadData()
    }
}
extension PesquisaLaboratorioViewController: UITextFieldDelegate{
    
    func textField(_ textField: UITextField,
        shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print(searchBarLaboratory.text ?? "Laboratório não encontrado")
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        searching = false
        tableViewLaboratory.reloadData()
    }
    
}
