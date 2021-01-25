//
//  LaboratorioViewModel.swift
//  DrugData
//
//  Created by Grazi Berti on 08/01/21.
//

import Foundation
import Alamofire
import SwiftyJSON

class CategoriaViewModel {
    
    var arrayRemedios = [Categoria] ()
    var hashRemedios: [String: [Categoria]] = [:]
    
    func loadCategoryAPI(completion: @escaping (_ result: Bool, _ error: Error?) -> Void) {
                   AF.request("https://raw.githubusercontent.com/paolapagotto/csvtojson/master/medicamentos.json").responseJSON { response in
                       if let arrayDictionary = response.value as? [[String: String]] {
                           
                           for item in arrayDictionary {
                               let brand = Categoria(json: JSON(item))
                            
                                let brandLab = brand.laboratorio
                                self.hashRemedios[brandLab, default: [Categoria]()].append(brand)
                               self.arrayRemedios.append(brand)
                           }
                           completion(true, nil)
                       } else {
                           completion(false, response.error)
                       }
                       
                   }
                   
               }
    func numberOfRows() -> Int {
            return arrayRemedios.count
        }
}
