//
//  TabbarVC.swift
//  SwimmingApp
//
//  Created by Monish M S on 18/07/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

import Foundation
import UIKit
class TabbarVC:UITabBarController{
     
    @IBOutlet var tabbar: UITabBar!
    
   override func viewDidLoad() {
        super.viewDidLoad()
        tabbar.backgroundColor = UIColor.black
        selectedIndex = 1
    }
}
