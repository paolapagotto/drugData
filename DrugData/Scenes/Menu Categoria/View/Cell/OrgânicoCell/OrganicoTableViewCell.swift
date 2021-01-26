//
//  OrganicoTableViewCell.swift
//  DrugData
//
//  Created by Igor Gavilon on 25/11/20.
//

import UIKit

class OrganicoTableViewCell: UITableViewCell {

    @IBOutlet weak var labelDrugName: UILabel!
    @IBOutlet weak var labelOrganicName: UILabel!
    
    @IBOutlet weak var labelLaboratoryName: UILabel!
    
    /*func setup(name: Categoria){
        self.labelDrugName.text = name.produto
        self.labelOrganicName.text = name.organico
    }*/
    func setup(name: Categoria) -> Void {
            
        self.labelDrugName.text = name.produto
        self.labelOrganicName.text = name.tipoProduto
        self.labelLaboratoryName.text = name.laboratorio
            
        }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
