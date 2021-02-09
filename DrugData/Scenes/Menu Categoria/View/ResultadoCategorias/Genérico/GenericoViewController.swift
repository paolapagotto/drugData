//
//  GenericoViewController.swift
//  DrugData
//
//  Created by Grazi Berti on 22/11/20.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKLoginKit
import FBSDKCoreKit
import FacebookLogin

class GenericoViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var labelLocation: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var searchBarGenerics: UISearchBar!
    @IBOutlet weak var imageViewAvatar: UIImageView!
    @IBOutlet weak var tableViewGeneric: UITableView!
    @IBOutlet weak var activityIndicatorTableLoading: UIActivityIndicatorView!

    var categoriaViewModel: CategoriaViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoriaViewModel = CategoriaViewModel()
        cornerRadiusView()
        userFirebase()
      
        searchBarGenerics.delegate = self
        categoriaViewModel?.filteredGeneric = categoriaViewModel!.arrayGenericos
    
        tableViewGeneric.delegate = self
        tableViewGeneric.dataSource = self
        
        loadGenericData()
        
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
    
    
    func orderArray() {
        let sortedArray = categoriaViewModel?.arrayGenericos.sorted{
            return $0.produto < $1.produto
        }
        categoriaViewModel?.arrayGenericos = sortedArray!
    }
    func orderFilteredArray() {
        let sortedArray = categoriaViewModel?.filteredGeneric.sorted{
            return $0.produto < $1.produto
        }
        categoriaViewModel?.filteredGeneric = sortedArray!
    }
    
    func loadGenericData() {
        categoriaViewModel?.loadCategoryAPI(completion: {  (sucess, error) in
                   if sucess {
                       DispatchQueue.main.async {
                        self.categoriaViewModel?.filteredGeneric = self.categoriaViewModel!.arrayGenericos
                            self.orderArray()
                            self.orderFilteredArray()
                           self.tableViewGeneric.reloadData()
                        self.activityIndicatorTableLoading.stopAnimating()
                        self.activityIndicatorTableLoading.hidesWhenStopped = true
                       }
                   }
        })
    }
    
    //MARK: SearchBar Delegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        categoriaViewModel?.filteredGeneric = []
        
        if searchText == "" {
            categoriaViewModel?.filteredGeneric = categoriaViewModel!.arrayGenericos
        } else {
            for generic in categoriaViewModel!.arrayGenericos {
                if generic.getTeam().lowercased().contains(searchText.lowercased()) {
                    categoriaViewModel?.filteredGeneric.append(generic)
                }
            }
        }

        tableViewGeneric.reloadData()
       
    }
    
}
extension GenericoViewController: UITableViewDelegate{
    
    
}
extension GenericoViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !searchBarShouldBeginEditing(searchBarGenerics){
            return (categoriaViewModel?.numberOfRowsGenericos())!
        }else if searchBarShouldBeginEditing(searchBarGenerics) {
            return (categoriaViewModel?.filteredGeneric.count)!
        }
                return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GenericoTableViewCell", for: indexPath) as! GenericoTableViewCell
       
        cell.setup(name: categoriaViewModel!.filteredGeneric[indexPath.row])
        return cell
    }
    
    
}
extension GenericoViewController{
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
}

