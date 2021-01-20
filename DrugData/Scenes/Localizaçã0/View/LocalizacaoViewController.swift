//
//  LocalizacaoViewController.swift
//  DrugData
//
//  Created by Grazi Berti on 22/11/20.
//

import UIKit

class LocalizacaoViewController: UIViewController {

    @IBOutlet weak var viewBlue: UIView!
    @IBOutlet weak var imageViewAvatar: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelLocation: UILabel!
    @IBOutlet weak var imageViewMap: UIImageView!
    var array = [Cabecalho] ()
    
    func setup(dados: Cabecalho) {
        labelName.text = dados.name
        labelLocation.text = dados.location
        imageViewAvatar.image = UIImage(named: "1.png")
        //imageViewMap.image = UIImage(named: "mapa.png")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup(dados: (Cabecalho(name: "Maria", location: "São Paulo - SP", profileImage: "1.png")))
        
        let alert = UIAlertController(title: "PERMITIR QUE A DROG DATA UTILIZE A SUA LOCALIZAÇÃO?",
                                      message: "A sua localização atual será apresentada no mapa  e usada para fornecer a farmácia mais proxima de você. ",
                                      preferredStyle: .alert)
      
        
        let cancelButton = UIAlertAction(title: "Permitir durante localização", style: .default, handler: nil)
        let cancelButton0 = UIAlertAction(title: "Permitir uma vez", style: .default, handler: nil)
        let addButton = UIAlertAction(title: "Não permitir", style: .default)
        
        alert.addAction(cancelButton)
        alert.addAction(cancelButton0)
        alert.addAction(addButton)
        
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: Métodos
    
}
    

   
