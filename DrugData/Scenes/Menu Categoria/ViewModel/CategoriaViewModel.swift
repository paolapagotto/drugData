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
    var arrayGenericos = [Categoria] ()
    var arrayOrganicos = [Categoria] ()
    var arrayTarjaPreta = [Categoria] ()
    var arrayTarjaVermelha = [Categoria] ()
    var arrayControlados = [Categoria] ()
    var hashControlados: [String: [Categoria]] = [:]
    var hashRemedios: [String: [Categoria]] = [:]
    
    // MARK: Atributos para SearchBar
    var filteredOrganic = [Categoria] ()
    var filteredGeneric = [Categoria] ()
    var filteredControlled = [Categoria] ()
    var filteredLab: [String: [Categoria]] = [:]
//    var array = [Categoria] ()
    var dictionary = ["LABORATORIO": [Categoria]()]
    
    func loadCategoryAPI(completion: @escaping (_ result: Bool, _ error: Error?) -> Void) {
        AF.request("https://raw.githubusercontent.com/paolapagotto/csvtojson/master/medicamentos.json").responseJSON { [self] response in
                       if let arrayDictionary = response.value as? [[String: String]] {
                           
                           for item in arrayDictionary {
                               let brand = Categoria(json: JSON(item))
                                self.arrayRemedios.append(brand)
                            
                                let brandLab = brand.laboratorio
                               self.hashRemedios[brandLab, default: [Categoria]()].append(brand)
                                
                                let typeProduto = brand.tipoProduto
                                if typeProduto == "GENÉRICO"{
                                    self.arrayGenericos.append(brand)
                                } else if typeProduto == "BIOLÓGICO" || typeProduto == "FITOTERÁPICO"{
                                    self.arrayOrganicos.append(brand)
                                }
                                
                                let typeControlados = brand.tipoControlados
                                self.hashControlados[typeControlados, default: [Categoria]()].append(brand)
                            
                                if typeControlados == "Tarja PRETA"{
                                    self.arrayControlados.append(brand)
                                    self.arrayTarjaPreta.append(brand)
                                }else if typeControlados == "Tarja VERMELHA"{
                                    self.arrayControlados.append(brand)
                                    self.arrayTarjaVermelha.append(brand)
                                }
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
    func numberOfRowsControlados() -> Int {
            return arrayControlados.count
        }
    func numberOfRowsGenericos() -> Int {
            return arrayGenericos.count
        }
    func numberOfRowsOrganicos() -> Int {
        return arrayOrganicos.count
        
        }
    func numberOfRowsLaboratorios() -> Int {
        print("\(hashRemedios.keys.count)")
        return hashRemedios.keys.count
        }
}
