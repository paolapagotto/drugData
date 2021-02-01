//
//  OrganicoViewController.swift
//  DrugData
//
//  Created by Grazi Berti on 22/11/20.
//

import UIKit

class OrganicoViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var labelLocation: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var searchBarOrganic: UISearchBar!
    @IBOutlet weak var imageViewAvatar: UIImageView!
    @IBOutlet weak var tableViewOrganic: UITableView!
    
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
        
        searchBarOrganic.delegate = self
        categoriaViewModel?.filteredOrganic = categoriaViewModel!.arrayOrganicos
        
        tableViewOrganic.delegate = self
        tableViewOrganic.dataSource = self

       
        loadOrganicData()
        
    }

    
    func loadOrganicData() {
        categoriaViewModel?.loadCategoryAPI(completion: {  (sucess, error) in
                   if sucess {
                       DispatchQueue.main.async {
                        self.categoriaViewModel?.filteredOrganic = self.categoriaViewModel!.arrayOrganicos
                           self.tableViewOrganic.reloadData()
                        //self.categoriaViewModel?.filteredOrganic = []
                        
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
                    categoriaViewModel?.filteredOrganic = []
                   loadOrganicData()
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
        if let allOrganic = categoriaViewModel?.numberOfRowsOrganicos() {
                    return allOrganic
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
