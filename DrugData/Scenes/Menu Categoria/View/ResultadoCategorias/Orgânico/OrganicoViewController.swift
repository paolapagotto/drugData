//
//  OrganicoViewController.swift
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

class OrganicoViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var labelLocation: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var searchBarOrganic: UISearchBar!
    @IBOutlet weak var imageViewAvatar: UIImageView!
    @IBOutlet weak var tableViewOrganic: UITableView!
    @IBOutlet weak var activityIndicatorTableLoading: UIActivityIndicatorView!
    
  
    var categoriaViewModel: CategoriaViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoriaViewModel = CategoriaViewModel()
        cornerRadiusView()
        userFirebase()
      
        searchBarOrganic.delegate = self
        categoriaViewModel?.filteredOrganic = categoriaViewModel!.arrayOrganicos
        
        tableViewOrganic.delegate = self
        tableViewOrganic.dataSource = self

       
        loadOrganicData()
        
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
        let sortedArray = categoriaViewModel?.arrayOrganicos.sorted{
            return $0.produto < $1.produto
        }
        categoriaViewModel?.arrayOrganicos = sortedArray!
    }
    func orderFilteredArray() {
        let sortedArray = categoriaViewModel?.filteredOrganic.sorted{
            return $0.produto < $1.produto
        }
        categoriaViewModel?.filteredOrganic = sortedArray!
    }
    
    func loadOrganicData() {
        categoriaViewModel?.loadCategoryAPI(completion: {  (sucess, error) in
                   if sucess {
                       DispatchQueue.main.async {
                        self.categoriaViewModel?.filteredOrganic = self.categoriaViewModel!.arrayOrganicos
                        self.orderArray()
                        self.orderFilteredArray()
                        self.tableViewOrganic.reloadData()
                        self.activityIndicatorTableLoading.stopAnimating()
                        self.activityIndicatorTableLoading.hidesWhenStopped = true
                        
                       }
                   }
        })
    }
    
    //MARK: SearchBar Delegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        categoriaViewModel?.filteredOrganic = []
        
        if searchText == "" {
            categoriaViewModel?.filteredOrganic = categoriaViewModel!.arrayOrganicos
        } else {
            for organic in categoriaViewModel!.arrayOrganicos {
                if organic.produto.lowercased().contains(searchText.lowercased()) {
                    categoriaViewModel?.filteredOrganic.append(organic)
                }
            }
        }

        tableViewOrganic.reloadData()
       
    }
    

}
extension OrganicoViewController: UITableViewDelegate{
    
}
extension OrganicoViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !searchBarShouldBeginEditing(searchBarOrganic){
            return (categoriaViewModel?.numberOfRowsOrganicos())!
        } else if searchBarShouldBeginEditing(searchBarOrganic) {
            return (categoriaViewModel?.filteredOrganic.count)!
        }
                
                return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrganicoTableViewCell", for: indexPath) as! OrganicoTableViewCell
        //cell.setup(name: categoriaViewModel!.arrayOrganicos[indexPath.row])
        cell.setup(name: (categoriaViewModel?.filteredOrganic[indexPath.row])!)
        return cell
    }
}

extension OrganicoViewController{
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
}
