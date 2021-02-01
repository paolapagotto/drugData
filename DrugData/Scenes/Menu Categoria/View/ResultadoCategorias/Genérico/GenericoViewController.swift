//
//  GenericoViewController.swift
//  DrugData
//
//  Created by Grazi Berti on 22/11/20.
//

import UIKit

class GenericoViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var labelLocation: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var searchBarGenerics: UISearchBar!
    @IBOutlet weak var imageViewAvatar: UIImageView!
    @IBOutlet weak var tableViewGeneric: UITableView!
    
    var array = [Cabecalho] ()
    var arrayMedice = [Remedios]()
    
    func setup(dados: Cabecalho) {
        labelName.text = dados.name
        labelLocation.text = dados.location
        imageViewAvatar.image = UIImage(named: "1.png")
    }
    
    var categoriaViewModel: CategoriaViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoriaViewModel = CategoriaViewModel()
        
        searchBarGenerics.delegate = self
        categoriaViewModel?.filteredGeneric = categoriaViewModel!.arrayGenericos
    
        tableViewGeneric.delegate = self
        tableViewGeneric.dataSource = self
    
        loadGenericData()
        
    }
    
    func loadGenericData() {
        categoriaViewModel?.loadCategoryAPI(completion: {  (sucess, error) in
                   if sucess {
                       DispatchQueue.main.async {
                        self.categoriaViewModel?.filteredGeneric = self.categoriaViewModel!.arrayGenericos
                           self.tableViewGeneric.reloadData()
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

