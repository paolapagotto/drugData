//
//  ControladosViewController.swift
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

class ControladosViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var labelLocation: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var searchBarControll: UISearchBar!
    @IBOutlet weak var imageViewAvatar: UIImageView!
    @IBOutlet weak var tableViewControll: UITableView!
    @IBOutlet weak var activityIndicatorTableLoading: UIActivityIndicatorView!
    
    
    var categoriaViewModel: CategoriaViewModel?
    
    
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
//            imageViewUserProfilePhoto.image = UIImage(named: "\(photoURL)") ?? UIImage(named: "userplaceholder.png")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoriaViewModel = CategoriaViewModel()
        
        userFirebase()
        searchBarControll.delegate = self
        categoriaViewModel?.filteredControlled = categoriaViewModel!.arrayControlados
        
        tableViewControll.delegate = self
        tableViewControll.dataSource = self

        orderArray()
        orderFilteredArray()
        loadControllData()
    }
    
    
    func orderArray() {
        let sortedArray = categoriaViewModel?.arrayControlados.sorted{
            return $0.produto < $1.produto
        }
        categoriaViewModel?.arrayControlados = sortedArray!
    }
    func orderFilteredArray() {
        let sortedArray = categoriaViewModel?.filteredControlled.sorted{
            return $0.produto < $1.produto
        }
        categoriaViewModel?.filteredControlled = sortedArray!
    }
    
    
    
    func loadControllData() {
        categoriaViewModel?.loadCategoryAPI(completion: {  (sucess, error) in
                   if sucess {
                       DispatchQueue.main.async {
                        self.categoriaViewModel?.filteredControlled = self.categoriaViewModel!.arrayControlados
                        self.orderArray()
                        self.orderFilteredArray()
                        self.tableViewControll.reloadData()
                        self.activityIndicatorTableLoading.stopAnimating()
                        self.activityIndicatorTableLoading.hidesWhenStopped = true
                       }
                   }
        })
    }
    //MARK: SearchBar Delegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        categoriaViewModel?.filteredControlled = []
        
        if searchText == "" {
            categoriaViewModel?.filteredControlled = categoriaViewModel!.arrayControlados
        } else {
            for controlled in categoriaViewModel!.arrayControlados {
                if controlled.produto.lowercased().contains(searchText.lowercased()) {
                    categoriaViewModel?.filteredControlled.append(controlled)
                }
            }
        }
       
        tableViewControll.reloadData()
       
    }
   

}
extension ControladosViewController: UITableViewDelegate{
    
}
extension ControladosViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        if !searchBarShouldBeginEditing(searchBarControll){
            return (categoriaViewModel?.numberOfRowsControlados())!
        }else if searchBarShouldBeginEditing(searchBarControll){
            return (categoriaViewModel?.filteredControlled.count)!
        }
                return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ControladosTableViewCell", for: indexPath) as! ControladosTableViewCell
        cell.setup(name: categoriaViewModel!.filteredControlled[indexPath.row])
        return cell
    }
    
}
extension ControladosViewController{
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
}
