//
//  LocationSearchVC.swift
//  SwimmingApp
//
//  Created by Monish M S on 18/07/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

import Foundation
import UIKit
class LocationSearchVC:UIViewController{
    
    @IBOutlet var header: CommonHeader!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        header.backButtonHeight.constant = 0
        header.backButtonWidth.constant = 0
    }
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        //self.performSegue(withIdentifier: "segueToHomeDashBoard", sender: nil)
        self.performSegue(withIdentifier: "locationSearchSegueToExploreListSegue", sender: nil)
        
    }
    
}
