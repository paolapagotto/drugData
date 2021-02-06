//
//  Remedio.swift
//  DrugData
//
//  Created by Grazi Berti on 07/01/21.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol SearchBarRemedioProtocol {
    func getTeam() -> String
}

class Remedio {
    
    var product: String
    var nameLaboratory: String
    var productType: String
    var controlled: String
    var description: String
    var price: String
        
        init(json: JSON) {
            self.product = json["PRODUTO"].stringValue
            self.nameLaboratory = json[ "LABORATORIO"].stringValue
            self.productType = json[ "TIPO DE PRODUTO"].stringValue
            self.controlled = json["TARJA"].stringValue
            self.description = json["APRESENTACAO"].stringValue
            self.price = json["PRECO FINAL"].stringValue
        }
    
    func resultOfSearch(){
        
    }
}
extension Remedio: SearchBarRemedioProtocol {
    func getTeam() -> String {
        return "\(product)".lowercased()
    }
    func getTeamLab() -> String {
        return "\(nameLaboratory)".lowercased()
    }
}
