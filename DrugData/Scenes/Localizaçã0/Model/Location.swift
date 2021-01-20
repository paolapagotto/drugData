//
//  Location.swift
//  DrugData
//
//  Created by Grazi Berti on 20/01/21.
//

import UIKit
import CoreLocation


class Location: NSObject {
    
    func convertLocation(endereco:String, local:@escaping(_ local:CLPlacemark) -> Void) {
        let convert = CLGeocoder()
        convert.geocodeAddressString(endereco) { (listLocation, error) in
            if let location = listLocation?.first {
                local(location)
            }
        }
    }
}
