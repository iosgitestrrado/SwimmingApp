//
//  CourseDetailsTitleView.swift
//  SwimmingApp
//
//  Created by Monish M S on 26/07/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

import Foundation
import UIKit
class CourseDetailsTitleView:UIView{
    
    @IBOutlet var packageName: ExpansionButton!
    @IBOutlet var packageExpandImageButton: UIButton!
    @IBOutlet var courseDetailsTopView: UIView!
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "CourseDetailsTitleView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
}
