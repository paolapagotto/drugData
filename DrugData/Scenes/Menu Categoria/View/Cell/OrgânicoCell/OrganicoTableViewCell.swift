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
    
    /*func setup(name: Categoria){
        self.labelDrugName.text = name.produto
        self.labelOrganicName.text = name.organico
    }*/
    func setup(name: Categoria) -> Void {
            if (name.tipoProduto == "Biologicos" || name.tipoProduto == "Biologico" ){
                self.labelDrugName.text = name.produto
                self.labelOrganicName.text = name.tipoProduto
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
