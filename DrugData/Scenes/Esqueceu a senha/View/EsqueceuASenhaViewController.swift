//
//  EsqueceuASenhaViewController.swift
//  DrugData
//
//  Created by Grazi Berti on 11/11/20.
//

import UIKit

class EsqueceuASenhaViewController: UIViewController {

    @IBOutlet weak var labelPasswordText: UILabel!
    var text: String = "CASO ESTEJA CADASTRADO EM NOSSO SISTEMA, RECEBERA EM INSTANTES UM EMAIL PARA CONFIGURAR UMA NOVA SENHA."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelPasswordText.text = text
    }
    
    

}
