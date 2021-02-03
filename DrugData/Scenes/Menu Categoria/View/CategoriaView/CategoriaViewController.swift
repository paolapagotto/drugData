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
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
      
    }

    @IBAction func buttonLaboratory(_ sender: Any) {
        if let filterLaboratory = UIStoryboard(name: "PesquisaLaboratorioViewController", bundle: nil).instantiateInitialViewController() as? PesquisaLaboratorioViewController {
            navigationController?.pushViewController(filterLaboratory, animated: true)
        }
    }
    
    @IBAction func buttonGeneric(_ sender: Any) {
        if let filterLaboratory = UIStoryboard(name: "GenericoViewController", bundle:
            nil).instantiateInitialViewController() as? GenericoViewController {
            navigationController?.pushViewController(filterLaboratory, animated: true)
        }
    }
    
    @IBAction func buttonControlMedice(_ sender: Any) {
        if let filterLaboratory = UIStoryboard(name: "ControladosViewController", bundle:
            nil).instantiateInitialViewController() as? ControladosViewController {
            navigationController?.pushViewController(filterLaboratory, animated: true)
        }
    }
    
    @IBAction func buttonOrganic(_ sender: Any) {
        if let filterLaboratory = UIStoryboard(name: "OrganicoViewController", bundle:
            nil).instantiateInitialViewController() as? OrganicoViewController {
            navigationController?.pushViewController(filterLaboratory, animated: true)
        }
    }
}
