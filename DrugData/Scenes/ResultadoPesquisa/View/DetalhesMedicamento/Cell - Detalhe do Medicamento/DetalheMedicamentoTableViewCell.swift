//
//  DetalheMedicamentoTableViewCell.swift
//  DrugData
//
//  Created by Grazi Berti on 22/11/20.
//

import UIKit

class DetalheMedicamentoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelNameMedice: UILabel!
    @IBOutlet weak var labelNameLaboratory: UILabel!
    @IBOutlet weak var labelNameCategory: UILabel!
    @IBOutlet weak var labelPreco: UILabel!
    @IBOutlet weak var imageViewMedicine: UIImageView!
    
  
    
    func setup(details: Remedios) {
        labelNameMedice.text = details.name
        labelNameLaboratory.text = details.nameLaboratory
        labelNameCategory.text = details.nameCategory
        labelPreco.text = details.preco
        //imageViewMedicine.image = UIImage(named: "remedio.png")
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

 }

