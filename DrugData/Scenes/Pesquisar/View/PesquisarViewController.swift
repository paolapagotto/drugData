//
//  PesquisarViewController.swift
//  DrugData
//
//  Created by Grazi Berti on 12/11/20.
//

import UIKit

class PesquisarViewController: UIViewController {

    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelLocation: UILabel!
    @IBOutlet weak var imageViewAvatar: UIImageView!
    
    
    @IBOutlet weak var textFieldNameMedice: UITextField!
    @IBOutlet weak var textFieldFilterSubstance: UITextField!
    @IBOutlet weak var textFieldFilterCategory: UITextField!
    
    var array = [Cabecalho] ()
    
    func setup(dados: Cabecalho) {
        labelName.text = dados.name
        labelLocation.text = dados.location
        imageViewAvatar.image = UIImage(named: "1.png")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup(dados: (Cabecalho(name: "Maria", location: "São Paulo", profileImage: "1.png")))
    }
    @IBAction func buttonSearchMedice(_ sender: Any) {
        if let search = UIStoryboard(name: "ResultadoPesquisaViewController", bundle: nil).instantiateInitialViewController() as? ResultadoPesquisaViewController{
            navigationController?.pushViewController(search, animated: true)
        }
    }
}
