//
//  LoadingViewController.swift
//  DrugData
//
//  Created by Grazi Berti on 22/01/21.
//

import UIKit

class AiewController: UIViewController {
    
    private let isUserLoggedIn = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showInitialView()
    }
    
    private func setupViews() {
        view.backgroundColor = .blue
    }
    
    private func showInitialView() {
        if isUserLoggedIn {
            
        } else {
            performSegue(withIdentifier: "LoadingViewController", sender: nil)
        }
    }

}
