//
//  Laboratorio.swift
//  DrugData
//
//  Created by Grazi Berti on 08/01/21.
//

import Foundation
import SwiftyJSON

class Categoria {
    
    var produto:String
    var laboratorio: String
    var generico: String
    var controlados: String
    var organico: String
       
     init(json: JSON) {
        
        self.produto = json["PRODUTO"].stringValue
        self.laboratorio = json["LABORATORIO"].stringValue
        self.generico = json["TIPO DE PRODUTO "].stringValue
        self.controlados = json["TARJA"].stringValue
        self.organico = json["CLASSE TERAPEUTICA"].stringValue
            
        }
}
