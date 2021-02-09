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
    @IBOutlet weak var labelProductControl: UILabel!
    @IBOutlet weak var labelProductDescription: UILabel!
    
    @IBOutlet weak var labelProductPrice: UILabel!
    
    var getMedicine: Remedio?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.labelProductName.text = getMedicine!.product
        self.labelLaboratoryName.text = "Laboratório: \(getMedicine!.nameLaboratory)"
        self.labelProductType.text = "Categoria: \(getMedicine!.productType)"
        self.labelProductPrice.text! = "Preço: \(getMedicine!.price)"
        self.labelProductControl.text = "Tipo: \(getMedicine!.controlled)"
        self.labelProductDescription.text = "Composição: \(getMedicine!.description)"
       
        
        if getMedicine!.productType == "BIOLÓGICO" || getMedicine!.productType == "FITOTERÁPICO"{
            self.imageViewProduct.image = UIImage(named: "imgorganico.png")
        } else if getMedicine!.productType == "GENÉRICO" && (getMedicine!.controlled == "Tarja VERMELHA" || getMedicine!.controlled == "Tarja VERMELHA(*)"){
            self.imageViewProduct.image = UIImage(named: "imggenericotarjavermelha.png")
        } else if getMedicine!.productType == "GENÉRICO" && getMedicine!.controlled == "Tarja PRETA"{
            self.imageViewProduct.image = UIImage(named: "imggenericotarjapreta.png")
        } else if getMedicine!.controlled == "Tarja PRETA"{
            self.imageViewProduct.image = UIImage(named: "imgtarjapreta.png")
        } else if getMedicine!.controlled == "Tarja VERMELHA" ||  getMedicine!.controlled == "Tarja VERMELHA(*)"{
            self.imageViewProduct.image = UIImage(named: "imgtarjavermelha.png")
        } else if getMedicine!.productType == "GENÉRICO"{
            self.imageViewProduct.image = UIImage(named: "imggenerico.png")
        } else {
            self.imageViewProduct.image = UIImage(named: "imgremedio.png")
        }
        
        
    }
    
    func setup(remedio: Remedio){
        self.getMedicine = remedio

    }
    
}
