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
    var tipoProduto: String
    var tipoControlados: String
    var classeTerapeutica: String
       
     init(json: JSON) {
        
        self.produto = json["PRODUTO"].stringValue
        self.laboratorio = json["LABORATORIO"].stringValue
        self.tipoProduto = json["TIPO DE PRODUTO"].stringValue
        self.tipoControlados = json["TARJA"].stringValue
        self.classeTerapeutica = json["CLASSE TERAPEUTICA"].stringValue
            
        }
    
    func filtroCategoria(remedio: Categoria){
        if(remedio.tipoProduto == "GENERICO"){
            self.tipoProduto = remedio.tipoProduto
            
        }else if(remedio.tipoProduto == "Biologico"){
            self.tipoProduto = remedio.tipoProduto
            
        }
    }
}
