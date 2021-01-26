//
//  DetalhesMedicamentoViewController.swift
//  DrugData
//
//  Created by Grazi Berti on 23/11/20.
//

import UIKit

class DetalhesMedicamentoViewController: UIViewController {
   
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameDrug: UILabel!
    @IBOutlet weak var laboratoryName: UILabel!
    @IBOutlet weak var categoryDrug: UILabel!
    @IBOutlet weak var priceDrug: UILabel!
    
    var drugDetail: Remedios?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImage(remedio: drugDetail!)
        //self.imageView.image = UIImage(named: "remedio.png")
        self.nameDrug.text = "Preço: R$\(drugDetail!.name)"
        self.laboratoryName.text = "Laboratório: \(drugDetail!.nameLaboratory)"
        self.categoryDrug.text = "Categoria: \(drugDetail!.nameCategory)"
        self.priceDrug.text! = "Preço: R$\(drugDetail!.preco)"
    }
    
    func setupImage(remedio: Remedios){
        
        if remedio.nameCategory == "BIOLÓGICO" || remedio.nameCategory == "FITOTERÁPICO"{
            return self.imageView.image = UIImage(named: "imgorganico.png")
        } else if remedio.nameCategory == "GENÉRICO" && remedio.productType == "Tarja VERMELHA"{
            return self.imageView.image = UIImage(named: "imggenericotarjavermelha.png")
        } else if remedio.nameCategory == "GENÉRICO" && remedio.productType == "Tarja PRETA"{
            return self.imageView.image = UIImage(named: "imggenericotarjapreta.png")
        } else if remedio.productType == "Tarja PRETA"{
            return self.imageView.image = UIImage(named: "imgtarjapreta.png")
        } else if remedio.productType == "Tarja VERMELHA"{
            return self.imageView.image = UIImage(named: "imgtarjavermelha.png")
        } else if remedio.nameCategory == "GENÉRICO"{
            return self.imageView.image = UIImage(named: "imggenerico.png")
        }
        return self.imageView.image = UIImage(named: "imgremedio.png")
    }
    
    func setup(remedio: Remedios){
        self.drugDetail = remedio
    }
    
}
