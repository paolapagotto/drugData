//
//  DetalhesMedicamentoViewController.swift
//  DrugData
//
//  Created by Grazi Berti on 23/11/20.
//

import UIKit

class DetalhesMedicamentoViewController: UIViewController {
   
    @IBOutlet weak var imageViewProduct: UIImageView!
    @IBOutlet weak var labelProductName: UILabel!
    @IBOutlet weak var labelLaboratoryName: UILabel!
    @IBOutlet weak var labelProductType: UILabel!
    @IBOutlet weak var labelProductPrice: UILabel!
    
    var drugDetail: Remedio?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.labelProductName.text = "Nome: \(drugDetail!.product)"
        self.labelLaboratoryName.text = "Laboratório: \(drugDetail!.nameLaboratory)"
        self.labelProductType.text = "Categoria: \(drugDetail!.productType)"
        self.labelProductPrice.text! = "Preço: \(drugDetail!.price)"
        //self.setupImage(remedio: labelProductType.text!)
    }
    
    
    


func setupImage(remedio: String){
    
    if remedio == "BIOLÓGICO" || remedio == "FITOTERÁPICO"{
        return imageViewProduct.image = UIImage(named: "imgorganico.png")
    } else if remedio == "GENÉRICO" && remedio == "Tarja VERMELHA"{
        return imageViewProduct.image = UIImage(named: "imggenericotarjavermelha.png")
    } else if remedio == "GENÉRICO" && remedio == "Tarja PRETA"{
        return imageViewProduct.image = UIImage(named: "imggenericotarjapreta.png")
    } else if remedio == "Tarja PRETA"{
        return imageViewProduct.image = UIImage(named: "imgtarjapreta.png")
    } else if remedio == "Tarja VERMELHA"{
        return imageViewProduct.image = UIImage(named: "imgtarjavermelha.png")
    } else if remedio == "GENÉRICO"{
        return imageViewProduct.image = UIImage(named: "imggenerico.png")
    } else {
        return self.imageViewProduct.image = UIImage(named: "imgremedio.png")
    }
}

    
    
    func setup(remedio: Remedio){
        self.drugDetail = remedio

    }
    
}
