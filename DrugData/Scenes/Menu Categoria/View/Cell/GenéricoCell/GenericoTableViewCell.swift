//
//  GenericoTableViewCell.swift
//  DrugData
//
//  Created by Igor Gavilon on 24/11/20.
//

import UIKit

class GenericoTableViewCell: UITableViewCell {

    @IBOutlet weak var labelNameDrug: UILabel!
    @IBOutlet weak var labelGenericName: UILabel!
    
    func setup(name: Categoria){
        if name.tipoProduto == "GENÉRICO"{
            self.labelNameDrug.text = name.produto
            self.labelGenericName.text = name.tipoProduto
        }
        
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
