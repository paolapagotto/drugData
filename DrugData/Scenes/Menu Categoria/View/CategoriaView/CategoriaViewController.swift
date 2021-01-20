//
//  CategoriaViewController.swift
//  DrugData
//
//  Created by Grazi Berti on 18/11/20.
//

import UIKit

class CategoriaViewController: UIViewController {

    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelLocation: UILabel!
    @IBOutlet weak var imageViewAvatar: UIImageView!
    
    var array = [Cabecalho] ()
    func setup(dados: Cabecalho) {
        labelName.text = dados.name
        labelLocation.text = dados.location
        imageViewAvatar.image = UIImage(named: "1.png")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setup(dados: (Cabecalho(name: "Maria", location: "São Paulo", profileImage: "1.png")) )
    }

    @IBAction func buttonLaboratory(_ sender: Any) {
        if let filterLaboratory = UIStoryboard(name: "PesquisaLaboratorioViewController", bundle: nil).instantiateInitialViewController() as? PesquisaLaboratorioViewController {
            navigationController?.pushViewController(filterLaboratory, animated: true)
        }
    }
    
    @IBAction func buttonGeneric(_ sender: Any) {
        if let filterLaboratory = UIStoryboard(name: "GenericoViewController", bundle: nil).instantiateInitialViewController() as? GenericoViewController {
            navigationController?.pushViewController(filterLaboratory, animated: true)
        }
    }
    
    @IBAction func buttonControlMedice(_ sender: Any) {
        if let filterLaboratory = UIStoryboard(name: "ControladosViewController", bundle: nil).instantiateInitialViewController() as? ControladosViewController {
            navigationController?.pushViewController(filterLaboratory, animated: true)
        }
    }
    
    @IBAction func buttonOrganic(_ sender: Any) {
        if let filterLaboratory = UIStoryboard(name: "OrganicoViewController", bundle: nil).instantiateInitialViewController() as? OrganicoViewController {
            navigationController?.pushViewController(filterLaboratory, animated: true)
        }
    }
}
