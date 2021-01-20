//
//  Remedio.swift
//  DrugData
//
//  Created by Grazi Berti on 07/01/21.
//

import Foundation
import Alamofire
import SwiftyJSON

class Remedio {
    
    var produto: String
    //var apresentacao: String
        
        init(json: JSON) {
            self.produto = json["PRODUTO"].stringValue
            //self.apresentacao = json["APRESENTACAO"].stringValue
        }
}
