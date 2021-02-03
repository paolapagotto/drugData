//
//  ResultadoPesquisaViewController.swift
//  DrugData
//
//  Created by Grazi Berti on 16/11/20.
//

import UIKit



class ResultadoPesquisaViewController: UIViewController {

    // MARK: IBOutlet
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelLocation: UILabel!
    @IBOutlet weak var imageViewAvatar: UIImageView!
    @IBOutlet weak var tableViewResult: UITableView!
    
    
    
    // MARK: Atributos
    var searchTerm: String = ""
    var resultadoPesquisaViewModel: ResultadoPesquisaViewModel?
    var filteredRemedios = [Remedio] ()
    var arrayRemedios = [Remedio] ()
    
    var pesquisarViewController: PesquisarViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultadoPesquisaViewModel = ResultadoPesquisaViewModel()
        pesquisarViewController = PesquisarViewController()
        
        tableViewResult.delegate = self
        tableViewResult.dataSource = self
        
        
        
        loadBrandData()
    }
    
    // MARK: Métodos

    func loadBrandData() {
        resultadoPesquisaViewModel?.loadBrandAPI(completion: {  (sucess, error) in
                   if sucess {
                       DispatchQueue.main.async {
                        self.pesquisarViewController?.filteredRemedios = self.pesquisarViewController!.arrayRemedios
                           self.tableViewResult.reloadData()
                       }
                   }
               })
    }
    

}

    // MARK: Extensions
extension ResultadoPesquisaViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let medicineDetails = UIStoryboard(name: "DetalhesMedicamentoViewController", bundle: nil).instantiateInitialViewController() as? DetalhesMedicamentoViewController {
            //medicineDetails.setup(remedio: arrayMedice[indexPath.row])
            navigationController?.pushViewController(medicineDetails, animated: true)
        }
    }
}
extension ResultadoPesquisaViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let allDrugs = pesquisarViewController?.filteredRemedios.count {
                    return allDrugs
                }
                
                return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NomeRemediosTableViewCell", for: indexPath) as! NomeRemediosTableViewCell
        
        cell.setup(remedio: resultadoPesquisaViewModel!.filteredRemedios[indexPath.row])
        return cell
        }
    
}



