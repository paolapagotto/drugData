//
//  PesquisaLaboratorioViewController.swift
//  DrugData
//
//  Created by Grazi Berti on 16/11/20.
//

import UIKit

class PesquisaLaboratorioViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelLocation: UILabel!
    @IBOutlet weak var imageViewAvatar: UIImageView!
    @IBOutlet weak var searchBarLaboratory: UISearchBar!
    @IBOutlet weak var tableViewLaboratory: UITableView!
    
    
    var arrayLaboratories = [String]()
    var searchLaboratories = [String]()
    var searching = false
    var categoriaViewModel: CategoriaViewModel?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoriaViewModel = CategoriaViewModel()
        
        tableViewLaboratory.delegate = self
        tableViewLaboratory.dataSource = self
        
        searchBarLaboratory.delegate = self
        
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
        if let allLabs = categoriaViewModel?.numberOfRowsLaboratorios() {
//            if searching {
//                return searchLaboratories.count
//            }
            return allLabs
        }
                return 0
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LaboratorioTableViewCell", for: indexPath) as! LaboratorioTableViewCell
        var a = Array(categoriaViewModel!.hashRemedios).count
        print(a)
        cell.setup(name: Array(categoriaViewModel!.hashRemedios.keys)[indexPath.row])
        return cell
        
    }
}

extension PesquisaLaboratorioViewController {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            print(searchBarLaboratory.text ?? "Laboratório não encontrado")
        }
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText:String){
//            searchLaboratories = categoriaViewModel!.hashRemedios.keys.filter({
//                $0.categoriaViewModel!.hashRemedios.keys.contains(searchText)
//            })
//            searching = true
//            tableViewLaboratory.reloadData()
//    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searching = false
            
            return tableViewLaboratory.reloadData()
    }
}
extension PesquisaLaboratorioViewController: UITextFieldDelegate{
    
    func textField(_ textField: UITextField,
        shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print(searchBarLaboratory.text ?? "Laboratório não encontrado")
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        searching = false
        tableViewLaboratory.reloadData()
    }
    
}
