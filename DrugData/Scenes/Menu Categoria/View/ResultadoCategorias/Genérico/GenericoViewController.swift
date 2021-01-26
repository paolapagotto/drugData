//
//  GenericoViewController.swift
//  DrugData
//
//  Created by Grazi Berti on 22/11/20.
//

import UIKit

class GenericoViewController: UIViewController {
    
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
        
        tableViewGeneric.delegate = self
        tableViewGeneric.dataSource = self

        setup(dados: (Cabecalho(name: "Maria", location: "São Paulo", profileImage: "1.png")))
    
        loadGenericData()
    }
    
    func loadGenericData() {
        categoriaViewModel?.loadCategoryAPI(completion: {  (sucess, error) in
                   if sucess {
                       DispatchQueue.main.async {
                           self.tableViewGeneric.reloadData()
                       }
                   }
        })
    }
    
}
extension GenericoViewController: UITableViewDelegate{
    
    
}
extension GenericoViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let allGeneric = categoriaViewModel?.numberOfRowsGenericos() {

                    return allGeneric
                }
                
                return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GenericoTableViewCell", for: indexPath) as! GenericoTableViewCell
       
        cell.setup(name: categoriaViewModel!.arrayGenericos[indexPath.row])
        return cell
    }
    
    
}
