//
//  NomeRemediosTableViewCell.swift
//  DrugData
//
//  Created by Grazi Berti on 22/11/20.
//

import UIKit
import CoreData


class NomeRemediosTableViewCell: UITableViewCell {

    // MARK: IBoutlet
    @IBOutlet weak var labelNameProduct: UILabel!
    @IBOutlet weak var labelNameLaboratory: UILabel!
    @IBOutlet weak var labelProductControl: UILabel!
    @IBOutlet weak var labelProductType: UILabel!
    @IBOutlet weak var labelProductPrice: UILabel!
    @IBOutlet weak var saveFavoriteDrug: UIButton!
    
    // MARK: Atributos
    var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func saveFavoriteDrug(_ sender: Any) {
        let drug = Favorite(context: context)
        drug.drugsFavorite = labelNameProduct.text
        drug.drugLab = labelNameLaboratory.text
        drug.drugType = labelProductType.text
        drug.drugPrice = labelProductPrice.text
        drug.drugControl = labelProductControl.text
        
        //image
        if labelProductType.text == "BIOLÓGICO" || labelProductType.text == "FITOTERÁPICO"{
            drug.drugImage = "imgorganico.png"
        } else if labelProductType.text == "GENÉRICO" && (labelProductControl.text == "Tarja VERMELHA" || labelProductControl.text == "Tarja VERMELHA(*)"){
            drug.drugImage = "imggenericotarjavermelha.png"
        } else if labelProductType.text == "GENÉRICO" && labelProductControl.text == "Tarja PRETA"{
            drug.drugImage = "imggenericotarjapreta.png"
        } else if labelProductControl.text == "Tarja PRETA"{
            drug.drugImage = "imgtarjapreta.png"
        } else if labelProductControl.text == "Tarja VERMELHA" ||  labelProductControl.text == "Tarja VERMELHA(*)"{
            drug.drugImage = "imgtarjavermelha.png"
        } else if labelProductType.text == "GENÉRICO"{
            drug.drugImage = "imggenerico.png"
        } else {
            drug.drugImage = "imgremedio.png"
        }
        
        do {
            //saveFavoriteDrug.setImage(UIImage(named: "star.fill"), for: .normal)
            saveFavoriteDrug.tintColor = .yellow
                
                
//            (systemName: "star.fill")
//                                .foregroundColor(.yellow)
            try context.save()
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // MARK: Métodos
    func setup(remedio: Remedio) {
        labelNameProduct.text = remedio.product
        labelNameLaboratory.text = remedio.nameLaboratory
        labelProductType.text = remedio.productType
        labelProductPrice.text = remedio.price
        labelProductControl.text = remedio.controlled
        
        //drug.drugImage = Remedio
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
