//
//  DetalheMedicamentoTableViewCell.swift
//  DrugData
//
//  Created by Grazi Berti on 22/11/20.
//

import UIKit

class DetalheMedicamentoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelProductName: UILabel!
    @IBOutlet weak var labelLaboratoryName: UILabel!
    @IBOutlet weak var labelProductType: UILabel!
    @IBOutlet weak var labelProductPrice: UILabel!
    @IBOutlet weak var imageViewProduct: UIImageView!
    
  
    
    func setup(details: Remedio) {
        labelProductName.text = details.product
        labelLaboratoryName.text = details.nameLaboratory
        labelProductType.text = details.productType
        labelProductPrice.text = details.price
        
        setupImage(remedio: details)
        
        
    }
    
    func setupImage(remedio: Remedio){
        
        if remedio.productType == "BIOLÓGICO" || remedio.productType == "FITOTERÁPICO"{
            return imageViewProduct.image = UIImage(named: "imgorganico.png")
        } else if remedio.productType == "GENÉRICO" && remedio.productType == "Tarja VERMELHA"{
            return imageViewProduct.image = UIImage(named: "imggenericotarjavermelha.png")
        } else if remedio.productType == "GENÉRICO" && remedio.productType == "Tarja PRETA"{
            return imageViewProduct.image = UIImage(named: "imggenericotarjapreta.png")
        } else if remedio.productType == "Tarja PRETA"{
            return imageViewProduct.image = UIImage(named: "imgtarjapreta.png")
        } else if remedio.productType == "Tarja VERMELHA"{
            return imageViewProduct.image = UIImage(named: "imgtarjavermelha.png")
        } else if remedio.productType == "GENÉRICO"{
            return imageViewProduct.image = UIImage(named: "imggenerico.png")
        }
        return self.imageViewProduct.image = UIImage(named: "imgremedio.png")
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

 }

