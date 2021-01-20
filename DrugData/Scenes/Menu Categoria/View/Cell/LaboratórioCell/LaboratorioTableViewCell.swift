//
//  LaboratorioTableViewCell.swift
//  DrugData
//
//  Created by Igor Gavilon on 24/11/20.
//

import UIKit

class LaboratorioTableViewCell: UITableViewCell {

    @IBOutlet weak var labelLaboratoryName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setup(name: String){
        self.labelLaboratoryName.text = name
    }

}
