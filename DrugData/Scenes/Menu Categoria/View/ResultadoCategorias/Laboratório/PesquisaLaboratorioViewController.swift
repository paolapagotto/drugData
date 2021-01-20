//
//  PesquisaLaboratorioViewController.swift
//  DrugData
//
//  Created by Grazi Berti on 16/11/20.
//

import UIKit

class PesquisaLaboratorioViewController: UIViewController {

    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelLocation: UILabel!
    @IBOutlet weak var imageViewAvatar: UIImageView!
    @IBOutlet weak var searchBarLaboratory: UISearchBar!
    @IBOutlet weak var tableViewLaboratory: UITableView!
    
    var array = [Cabecalho] ()
    var arrayLaboratories = [String]()
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
        
        tableViewLaboratory.delegate = self
        tableViewLaboratory.dataSource = self
        
        loadLaboratoryData()
    }
  
    func loadLaboratoryData() {
        categoriaViewModel?.loadCategoryAPI(completion: {  (sucess, error) in
                   if sucess {
                       DispatchQueue.main.async {
                           self.tableViewLaboratory.reloadData()
                       }
                   }
        })
    }
    

}
extension PesquisaLaboratorioViewController: UITableViewDelegate{
    
}
extension PesquisaLaboratorioViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let allLabs = categoriaViewModel?.numberOfRows() {
                    return allLabs
                }
                
                return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LaboratorioTableViewCell", for: indexPath) as! LaboratorioTableViewCell
        cell.setup(name: categoriaViewModel!.arrayRemedios[indexPath.row].laboratorio)
        return cell
    }
    
    
}
