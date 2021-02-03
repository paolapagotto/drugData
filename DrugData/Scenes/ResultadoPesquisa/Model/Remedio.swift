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
    
    var produto: String
    var nameLaboratory: String
    var productType: String
    //var apresentacao: String
        
        init(json: JSON) {
            self.produto = json["PRODUTO"].stringValue
            self.nameLaboratory = json[ "LABORATORIO"].stringValue
            self.productType = json[ "TIPO DE PRODUTO"].stringValue
            //self.apresentacao = json["APRESENTACAO"].stringValue
        }
    
    func resultOfSearch(){
        
    }
}
extension Remedio: SearchBarRemedioProtocol {
    func getTeam() -> String {
        return "\(produto)".lowercased()
    }
    func getTeamLab() -> String {
        return "\(nameLaboratory)".lowercased()
    }
}
