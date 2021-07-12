//
//  ActivityListingTempVCCell.swift
//  SwimmingApp
//
//  Created by Monish M S on 19/09/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

import Foundation
import UIKit
class ActivityListingTempVCCell:UICollectionViewCell{
    
    @IBOutlet var activityName: UILabel!
    @IBOutlet var topView: UIView!
    @IBOutlet var activityImage: UIImageView!
    @IBOutlet weak var imgSubActivity: UIImageView!
    
//    @IBOutlet var middleView: UIView!
//    @IBOutlet var bottomView: UIView!
    
    @IBOutlet var topViewWidth: NSLayoutConstraint!
    @IBOutlet var topViewHeight: NSLayoutConstraint!
    @IBOutlet var middleViewHeight: NSLayoutConstraint!
    @IBOutlet var middleViewWidth: NSLayoutConstraint!
    @IBOutlet var bottomViewWidth: NSLayoutConstraint!
    @IBOutlet var bottomViewHeight: NSLayoutConstraint!
    @IBOutlet var imageViewWidth: NSLayoutConstraint!
    @IBOutlet var imageViewHeight: NSLayoutConstraint!
}
