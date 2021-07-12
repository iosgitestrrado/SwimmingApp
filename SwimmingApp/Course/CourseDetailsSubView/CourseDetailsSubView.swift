//
//  CourseDetailsSubView.swift
//  SwimmingApp
//
//  Created by Monish M S on 26/07/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

import Foundation
import UIKit
class CourseDetailsSubView:UIView{
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "CourseDetailsSubView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
}
