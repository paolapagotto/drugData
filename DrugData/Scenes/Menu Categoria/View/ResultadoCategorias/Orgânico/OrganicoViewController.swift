//
//  OrganicoViewController.swift
//  DrugData
//
//  Created by Grazi Berti on 22/11/20.
//

import UIKit

class OrganicoViewController: UIViewController {

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
        
        tableViewOrganic.delegate = self
        tableViewOrganic.dataSource = self

        setup(dados: (Cabecalho(name: "Maria", location: "São Paulo", profileImage: "1.png")))
        
        loadOrganicData()
    }
    
    func loadOrganicData() {
        categoriaViewModel?.loadCategoryAPI(completion: {  (sucess, error) in
                   if sucess {
                       DispatchQueue.main.async {
                           self.tableViewOrganic.reloadData()
                       }
                   }
        })
    }

}
extension OrganicoViewController: UITableViewDelegate{
    
}
extension OrganicoViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let allOrganic = categoriaViewModel?.numberOfRows() {
                    return allOrganic
                }
                
                return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrganicoTableViewCell", for: indexPath) as! OrganicoTableViewCell
        cell.setup(name: categoriaViewModel!.arrayOrganicos[indexPath.row])
        return cell
    }
    
    
}
