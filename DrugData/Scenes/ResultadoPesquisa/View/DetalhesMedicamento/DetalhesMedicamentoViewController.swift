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
    
    func setup(remedio: Remedio){
        self.drugDetail = remedio

    }
    
}
