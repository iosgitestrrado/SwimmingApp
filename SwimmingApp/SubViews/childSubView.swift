//
//  childSubView.swift
//  SwimmingApp
//
//  Created by Monish M S on 18/07/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

import Foundation
import UIKit
class childSubView:UIView{
    
    @IBOutlet var childNameTextField: TextField!
    @IBOutlet var guardianMobileNumberTextField: TextField!
    @IBOutlet var guardianEmailIdTextField: TextField!
    @IBOutlet var guardianRelationTextField: TextField!
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "childSubView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
}
