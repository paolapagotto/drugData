//
//  ResultadoPesquisaViewController.swift
//  DrugData
//
//  Created by Grazi Berti on 16/11/20.
//

import UIKit



class ResultadoPesquisaViewController: UIViewController, UISearchBarDelegate {

    // MARK: IBOutlet
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelLocation: UILabel!
    @IBOutlet weak var imageViewAvatar: UIImageView!
    @IBOutlet weak var tableViewResult: UITableView!
    
    @IBOutlet weak var searchBarAllDrugs: UISearchBar!
    
    
    // MARK: Atributos
        var searchTerm: String = ""
        var resultadoPesquisaViewModel: ResultadoPesquisaViewModel?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            resultadoPesquisaViewModel = ResultadoPesquisaViewModel()
            
            tableViewResult.delegate = self
            tableViewResult.dataSource = self
            
            searchBarAllDrugs.delegate = self
            loadBrandData()
        }
        
        // MARK: Métodos
    
        

        func loadBrandData() {
            resultadoPesquisaViewModel?.loadBrandAPI(completion: {  (sucess, error) in
                       if sucess {
                           DispatchQueue.main.async {
                            self.resultadoPesquisaViewModel?.filteredRemedios = self.resultadoPesquisaViewModel!.arrayRemedios
                               self.tableViewResult.reloadData()
                           }
                       }
                   })
        }
        //MARK: SearchBar Delegate
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            resultadoPesquisaViewModel?.filteredRemedios = []

            if searchText == "" {
                resultadoPesquisaViewModel?.filteredRemedios = resultadoPesquisaViewModel!.arrayRemedios
            } else {
                for allDrugs in resultadoPesquisaViewModel!.arrayRemedios {
                    if allDrugs.product.lowercased().contains(searchText.lowercased()) {
                        resultadoPesquisaViewModel?.filteredRemedios.append(allDrugs)
                    }
                }
            }
            tableViewResult.reloadData()
        }
}

    // MARK: Extensions
extension ResultadoPesquisaViewController: UITableViewDelegate {
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            if let medicineDetails = UIStoryboard(name: "DetalhesMedicamentoViewController", bundle: nil).instantiateInitialViewController() as? DetalhesMedicamentoViewController {
                navigationController?.pushViewController(medicineDetails, animated: true)
            }
        }
}
extension ResultadoPesquisaViewController: UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            if !searchBarShouldBeginEditing(searchBarAllDrugs){
                return (resultadoPesquisaViewModel?.arrayRemedios.count)!
            } else if searchBarShouldBeginEditing(searchBarAllDrugs) {
                return (resultadoPesquisaViewModel?.filteredRemedios.count)!
            }

                   return 0
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NomeRemediosTableViewCell", for: indexPath) as! NomeRemediosTableViewCell
            cell.setup(remedio: resultadoPesquisaViewModel!.filteredRemedios[indexPath.row])
            return cell
            }
    
        
}
extension ResultadoPesquisaViewController {
        
        func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
            return true
        }
        
    }


