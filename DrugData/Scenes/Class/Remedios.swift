//
//  Remedios.swift
//  DrugData
//
//  Created by Grazi Berti on 22/11/20.
//

import Foundation

class Remedios {
    var name: String
    var nameLaboratory: String
    var nameCategory: String
    var productType: String
    var preco: String
   
    
    init(name: String, nameLaboratory: String,nameCategory: String, productType: String, preco: String ) {
        self.name = name
        self.nameLaboratory = nameLaboratory
        self.nameCategory = nameCategory
        self.productType = productType
        self.preco = preco
        
    }
}
