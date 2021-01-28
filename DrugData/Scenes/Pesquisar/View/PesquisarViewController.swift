//
//  PesquisarViewController.swift
//  DrugData
//
//  Created by Grazi Berti on 12/11/20.
//

import UIKit


enum ProviderType: String {
    case basic
}

class PesquisarViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelLocation: UILabel!
    @IBOutlet weak var imageViewAvatar: UIImageView!
    
    
    @IBOutlet weak var textFieldNameMedice: UITextField!
    @IBOutlet weak var textFieldFilterSubstance: UITextField!
    @IBOutlet weak var textFieldFilterCategory: UITextField!
    
    
    private let email: String = ""
    //private let provider: ProviderType
    
    
//    var array = [Cabecalho] ()
//
//    func setup(dados: Cabecalho) {
//        labelName.text = dados.name
//        labelLocation.text = dados.location
//        imageViewAvatar.image = UIImage(named: "1.png")
//    }
    
    func reloadTextFieldSearch() {
        return textFieldNameMedice.text = ""
    }
    
    
    
    
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        textFieldNameMedice.delegate = self
        
    }
    @IBAction func buttonSearchMedice(_ sender: Any) {
        if let search = UIStoryboard(name: "ResultadoPesquisaViewController", bundle: nil).instantiateInitialViewController() as? ResultadoPesquisaViewController{
            navigationController?.pushViewController(search, animated: true)
        }
        reloadTextFieldSearch()
    }
}
