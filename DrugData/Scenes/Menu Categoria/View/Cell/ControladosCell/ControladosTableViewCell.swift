//
//  ControladosTableViewCell.swift
//  DrugData
//
//  Created by Igor Gavilon on 25/11/20.
//

import UIKit

class ControladosTableViewCell: UITableViewCell {

    @IBOutlet weak var labelDrugName: UILabel!
    @IBOutlet weak var labelControlledName: UILabel!
    
    func setup(name: Categoria){
        labelDrugName.text = name.produto
        labelControlledName.text = name.tipoControlados
        
        
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
