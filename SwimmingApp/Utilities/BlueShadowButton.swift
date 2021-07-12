//
//  BlueShadowButton.swift
//  SwimmingApp
//
//  Created by Monish M S on 18/07/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

import Foundation
import UIKit
class BlueShadowButton:UIButton{
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        createShadowButton()
    }
    
    func createShadowButton(){
        let color = UIColor(red: 41.0/255.0, green: 128.0/255.0, blue: 185.0/255.0, alpha: 1.0)
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 5.0
    }
}
class CyanShadowButton:UIButton{
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        createShadowButton()
    }
    
    func createShadowButton(){
        let color = UIColor(red: 75.0/255.0, green: 59.0/255.0, blue: 81.0/255.0, alpha: 1.0)
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 5.0
    }
}
