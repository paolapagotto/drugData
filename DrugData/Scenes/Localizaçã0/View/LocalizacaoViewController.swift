//
//  LocalizacaoViewController.swift
//  DrugData
//
//  Created by Grazi Berti on 22/11/20.
//

import UIKit
import MapKit
import Firebase
import GoogleSignIn
import FBSDKLoginKit
import FBSDKCoreKit
import FacebookLogin

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
        userFirebase()
        cornerRadiusView()
    }
 
    
    // MARK: Métodos
    func inicialLocation() {
        let user = Auth.auth().currentUser
        Location().convertLocation(endereco: "São Paulo - SP") { (findLocation) in
            let pino = self.confPino(name: (user?.displayName ?? "Você"), location: findLocation)
            
            let place = MKCoordinateRegion(center: pino.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
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
    func cornerRadiusView() {
        imageViewAvatar.layer.cornerRadius = imageViewAvatar.frame.width / 2
        imageViewAvatar.layer.borderWidth = 0.5
       
    }
    func userFirebase(){
        let user = Auth.auth().currentUser
        if let user = user {
          // The user's ID, unique to the Firebase project.
          // Do NOT use this value to authenticate with your backend server,
          // if you have one. Use getTokenWithCompletion:completion: instead.
          let uid = user.uid
          let name = user.displayName
            let photoURL = user.photoURL ?? URL(fileReferenceLiteralResourceName: "userplaceholder.png")
            labelName.text = name ?? "Olá"
            labelLocation.text = "São Paulo - SP"
            let data = try? Data(contentsOf: photoURL)
            if let imagedata = data {
                imageViewAvatar.image = UIImage(data: imagedata) ?? UIImage(named: "userplaceholder.png")
                cornerRadiusView()
            }
        }
    }
}
    

   
