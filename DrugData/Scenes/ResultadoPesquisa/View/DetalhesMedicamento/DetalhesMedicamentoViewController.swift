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
        self.imageView.image = UIImage(named: "remedio.png")
        self.nameDrug.text = "Preço: R$\(drugDetail!.name)"
        self.laboratoryName.text = "Laboratório: \(drugDetail!.nameLaboratory)"
        self.categoryDrug.text = "Categoria: \(drugDetail!.nameCategory)"
        self.priceDrug.text! = "Preço: R$\(drugDetail!.preco)"
    }
    func setup(remedio: Remedios){
        self.drugDetail = remedio
    }
    
}
