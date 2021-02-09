//
//  ResultadoPesquisaViewController.swift
//  DrugData
//
//  Created by Grazi Berti on 16/11/20.
//

import UIKit
import CoreData
import Firebase
import GoogleSignIn
import FBSDKLoginKit
import FBSDKCoreKit
import FacebookLogin


class ResultadoPesquisaViewController: UIViewController, UISearchBarDelegate {

    // MARK: IBOutlet
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelLocation: UILabel!
    @IBOutlet weak var imageViewAvatar: UIImageView!
    @IBOutlet weak var tableViewResult: UITableView!
    
    @IBOutlet weak var searchBarAllDrugs: UISearchBar!
    
    @IBOutlet weak var activityIndicatorTableLoading: UIActivityIndicatorView!
    
    // MARK: Atributos
        var searchTerm: String = ""
        
        var resultadoPesquisaViewModel: ResultadoPesquisaViewModel?
        var getMedicine: Remedio?
    
        override func viewDidLoad() {
            super.viewDidLoad()
            cornerRadiusView()
            userFirebase()
            resultadoPesquisaViewModel = ResultadoPesquisaViewModel()
            
            tableViewResult.delegate = self
            tableViewResult.dataSource = self
            
        
            searchBarAllDrugs.delegate = self
            loadBrandData()
        }
        
        // MARK: Métodos
    
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

        func loadBrandData() {
            resultadoPesquisaViewModel?.loadBrandAPI(completion: {  (sucess, error) in
                       if sucess {
                        DispatchQueue.main.async { [self] in
                            self.resultadoPesquisaViewModel?.filteredRemedios = self.resultadoPesquisaViewModel!.arrayRemedios
                               self.tableViewResult.reloadData()
                            self.activityIndicatorTableLoading.stopAnimating()
                            self.activityIndicatorTableLoading.hidesWhenStopped = true
                            
                           }
                       }
                   })
        }
        //MARK: SearchBar Delegate
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            resultadoPesquisaViewModel?.filteredRemedios = []

            if searchText == "" {
                resultadoPesquisaViewModel?.filteredRemedios = resultadoPesquisaViewModel!.arrayRemedios
            } else {
                for allDrugs in resultadoPesquisaViewModel!.arrayRemedios {
                    if allDrugs.product.lowercased().contains(searchText.lowercased()) {
                        resultadoPesquisaViewModel?.filteredRemedios.append(allDrugs)
                    }
                }
            }
            tableViewResult.reloadData()
        }
}

    // MARK: Extensions
extension ResultadoPesquisaViewController: UITableViewDelegate {
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            if let medicineDetails = UIStoryboard(name: "DetalhesMedicamentoViewController", bundle: nil).instantiateInitialViewController() as? DetalhesMedicamentoViewController {
                
                
                if !searchBarShouldBeginEditing(searchBarAllDrugs){
                    medicineDetails.getMedicine = (resultadoPesquisaViewModel?.arrayRemedios[indexPath.row])
                } else if searchBarShouldBeginEditing(searchBarAllDrugs) {
                    medicineDetails.getMedicine = (resultadoPesquisaViewModel?.filteredRemedios[indexPath.row])
                }
                
        
                
                navigationController?.pushViewController(medicineDetails, animated: true)
                
            }
        }
}
extension ResultadoPesquisaViewController: UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            if !searchBarShouldBeginEditing(searchBarAllDrugs){
                return (resultadoPesquisaViewModel?.arrayRemedios.count)!
            } else if searchBarShouldBeginEditing(searchBarAllDrugs) {
                return (resultadoPesquisaViewModel?.filteredRemedios.count)!
            }

                   return 0
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NomeRemediosTableViewCell", for: indexPath) as! NomeRemediosTableViewCell
            cell.setup(remedio: resultadoPesquisaViewModel!.filteredRemedios[indexPath.row])
            return cell
            }
    
        
}
extension ResultadoPesquisaViewController {
        
        func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
            return true
        }
        
    }


