//
//  PesquisarViewController.swift
//  DrugData
//
//  Created by Grazi Berti on 12/11/20.
//

import UIKit


class PesquisarViewController: UIViewController, UISearchBarDelegate {

    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelLocation: UILabel!
    @IBOutlet weak var imageViewAvatar: UIImageView!
    @IBOutlet weak var searchbarByName: UISearchBar!
    @IBOutlet weak var searchbarByLaboratory: UISearchBar!
    @IBOutlet weak var searchbarBySubstance: UISearchBar!
    
    var arrayRemedios = [Remedio] ()
    var filteredRemedios = [Remedio] ()
    var resultadoPesquisaViewModel: ResultadoPesquisaViewModel?
    var resultadoPesquisaViewController: ResultadoPesquisaViewController?
    //private let provider: ProviderType
    
    
//    var array = [Cabecalho] ()
//
//    func setup(dados: Cabecalho) {
//        labelName.text = dados.name
//        labelLocation.text = dados.location
//        imageViewAvatar.image = UIImage(named: "1.png")
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultadoPesquisaViewModel = ResultadoPesquisaViewModel()
        resultadoPesquisaViewController = ResultadoPesquisaViewController()
        searchbarByName.delegate = self
        searchbarByLaboratory.delegate = self
        searchbarBySubstance.delegate = self
        resultadoPesquisaViewModel?.filteredRemedios = resultadoPesquisaViewModel!.arrayRemedios
    }
    @IBAction func buttonSearchMedice(_ sender: Any) {
        if !filteredRemedios.isEmpty {
            
            resultadoPesquisaViewController?.tableViewResult.reloadData()
            if let search = UIStoryboard(name: "ResultadoPesquisaViewController", bundle: nil).instantiateInitialViewController() as? ResultadoPesquisaViewController{
                navigationController?.pushViewController(search, animated: true)
            }
        }
        
        
        
    }
    //MARK: SearchBar Delegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        resultadoPesquisaViewModel?.filteredRemedios = []
        
        if searchText == "" {
            resultadoPesquisaViewModel?.filteredRemedios = resultadoPesquisaViewModel!.arrayRemedios
        } else {
            for remedio in resultadoPesquisaViewModel!.arrayRemedios {
                if remedio.produto.lowercased().contains(searchText.lowercased()) {
                    resultadoPesquisaViewModel?.filteredRemedios.append(remedio)
                }
            }
        }
       
    }
    
}
extension PesquisarViewController{
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
}
