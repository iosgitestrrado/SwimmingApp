//
//  childBottomButtonView.swift
//  SwimmingApp
//
//  Created by Monish M S on 18/07/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

import Foundation
import UIKit
class childBottomButtonView:UIView{
    
    @IBOutlet var addButton: UIButton!
    @IBOutlet var submitButton: ShadowButton!
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "childBottomButtonView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
}
