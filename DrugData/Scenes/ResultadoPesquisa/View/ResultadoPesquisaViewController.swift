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
    var array = [Cabecalho] ()
    //var arrayMedice = [Remedios] ()
    var resultadoPesquisaViewModel: ResultadoPesquisaViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultadoPesquisaViewModel = ResultadoPesquisaViewModel()
        
        tableViewResult.delegate = self
        tableViewResult.dataSource = self
        
        
        
        loadBrandData()
    }
    
    // MARK: Métodos
    func setup(dados: Cabecalho) {
        labelName.text = dados.name
        labelLocation.text = dados.location
        imageViewAvatar.image = UIImage(named: "1.png")
        
    }
    
    func loadBrandData() {
        resultadoPesquisaViewModel?.loadBrandAPI(completion: {  (sucess, error) in
                   if sucess {
                       DispatchQueue.main.async {
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
        if let allDrugs = resultadoPesquisaViewModel?.numberOfRowsSearchByName() {
                    return allDrugs
                }
                
                return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NomeRemediosTableViewCell", for: indexPath) as! NomeRemediosTableViewCell
        
        cell.setup(nameMedice: resultadoPesquisaViewModel!.arraySearchByName[indexPath.row].produto, nameLaboratory: resultadoPesquisaViewModel!.arrayRemedios[indexPath.row].nameLaboratory, productType: resultadoPesquisaViewModel!.arrayRemedios[indexPath.row].productType )
        return cell
        }
    
}

