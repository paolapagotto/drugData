//
//  ImagePicker.swift
//  DrugData
//
//  Created by Grazi Berti on 14/01/21.
//

import UIKit

//  MARK: Enum
enum MenuDeOpcoes {
    case camera
    case biblioteca
}

//  MARK: Protocol
protocol ImagePickerFotoSelecionada {
    func imagePickerFotoSelecionada(_ foto: UIImage)
}

class ImagePicker: NSObject,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: Atributos
    var delegate: ImagePickerFotoSelecionada?
    
    //MARK: Métodos
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    
        let foto = info[UIImagePickerController.InfoKey.originalImage] as! UIImage; delegate?.imagePickerFotoSelecionada(foto)
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func menuDeOpcoes(completion:@escaping(_ opcao: MenuDeOpcoes) -> Void) -> UIAlertController {
        let menu = UIAlertController(title: "Atenção",
                                     message: "Escolha uma das opções abaixo:",
                                     preferredStyle: .actionSheet)
        
        let camera = UIAlertAction(title: "Tirar foto",
                                   style: .default) { (action) in
            completion(.camera)
        }
        
        let biblioteca = UIAlertAction(title: "Ir para biblioteca",
                                   style: .default) { (action) in
            completion(.biblioteca)
        }
        
        let cancelar = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        
        menu.addAction(camera)
        menu.addAction(biblioteca)
        menu.addAction(cancelar)
        
        
        
        return menu
    }
    
   
}

