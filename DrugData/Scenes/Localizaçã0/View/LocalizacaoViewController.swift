//
//  LocalizacaoViewController.swift
//  DrugData
//
//  Created by Grazi Berti on 22/11/20.
//

import UIKit
import MapKit

class LocalizacaoViewController: UIViewController {

    @IBOutlet weak var viewBlue: UIView!
    @IBOutlet weak var imageViewAvatar: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelLocation: UILabel!
    //@IBOutlet weak var imageViewMap: UIImageView!
    
    
    @IBOutlet weak var mapkitMap: MKMapView!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inicialLocation()
    }
    
    // MARK: Métodos
    func inicialLocation() {
        Location().convertLocation(endereco: "Av. Paulista, 1578 - Bela Vista, São Paulo - SP") { (findLocation) in
            let pino = self.confPino(name: "Maria", location: findLocation)
            
            let place = MKCoordinateRegion(center: pino.coordinate, latitudinalMeters: 5000, longitudinalMeters: 5000)
            self.mapkitMap.setRegion(place, animated: true)
            self.mapkitMap.addAnnotation(pino)
        }
    }
    
    func confPino(name: String, location: CLPlacemark) -> MKPointAnnotation {
        let pino = MKPointAnnotation()
        pino.title = name
        pino.coordinate = location.location!.coordinate
        
        
        return pino
    }
    
}
    

   
