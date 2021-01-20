//
//  ControladosGeralTableViewCell.swift
//  DrugData
//
//  Created by Grazi Berti on 19/11/20.
//

import UIKit

class ControladosGeralTableViewCell: UITableViewCell {

    @IBOutlet weak var labelMedice: UILabel!
    
    func setup(filter: String){
        labelMedice.text = filter
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
