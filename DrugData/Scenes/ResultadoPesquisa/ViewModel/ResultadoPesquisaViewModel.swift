//
//  ResultadoPesquisaViewModel.swift
//  DrugData
//
//  Created by Grazi Berti on 07/01/21.
//

import Foundation
import Alamofire
import SwiftyJSON


class ResultadoPesquisaViewModel {
    
    var textSearch : String = ""
    var arrayRemedios = [Remedio] ();
    var arraySearchByName = [Remedio] ()
    var hashRemedios: [String: [Remedio]] = [:]
    
    // MARK: Métodos
    func loadBrandAPI(completion: @escaping (_ result: Bool, _ error: Error?) -> Void) {
                   AF.request("https://raw.githubusercontent.com/paolapagotto/csvtojson/master/medicamentos.json").responseJSON { response in
                       if let arrayDictionary = response.value as? [[String: String]] {
                        
                        
                           for item in arrayDictionary {
                            
                                let brand = Remedio(json: JSON(item))
                                let brandLab = brand.nameLaboratory
                                self.hashRemedios[brandLab, default: [Remedio]()].append(brand)
                                self.arrayRemedios.append(brand)
                            
                                //self.searchByName(name: self.textSearch)
                           }
                        
                        
                            
                           completion(true, nil)
                       } else {
                           completion(false, response.error)
                       }
                       
                   }
                   
               }
    func searchByName(name: String){
        let brand = Remedio(json: JSON())
        if name.contains(brand.produto){
            self.arraySearchByName.append(brand)
        } else if brand.produto.contains(name){
            self.arraySearchByName.append(brand)
        }
    }
    
    func numberOfRows() -> Int {
            return arrayRemedios.count
        }
    
    func numberOfRowsSearchByName() -> Int {
            return arraySearchByName.count
        }
}
