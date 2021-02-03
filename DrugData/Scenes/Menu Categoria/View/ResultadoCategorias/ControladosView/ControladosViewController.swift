//
//  ControladosViewController.swift
//  DrugData
//
//  Created by Grazi Berti on 22/11/20.
//

import UIKit

class ControladosViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var labelLocation: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var searchBarControll: UISearchBar!
    @IBOutlet weak var imageViewAvatar: UIImageView!
    @IBOutlet weak var tableViewControll: UITableView!
    
    
    var categoriaViewModel: CategoriaViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoriaViewModel = CategoriaViewModel()
        
        searchBarControll.delegate = self
        categoriaViewModel?.filteredControlled = categoriaViewModel!.arrayControlados
        
        tableViewControll.delegate = self
        tableViewControll.dataSource = self

        
        loadControllData()
    }
    
    
    
    func loadControllData() {
        categoriaViewModel?.loadCategoryAPI(completion: {  (sucess, error) in
                   if sucess {
                       DispatchQueue.main.async {
                        self.categoriaViewModel?.filteredControlled = self.categoriaViewModel!.arrayControlados
                           self.tableViewControll.reloadData()
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
