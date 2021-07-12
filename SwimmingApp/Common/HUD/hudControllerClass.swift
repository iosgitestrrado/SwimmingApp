//
//  hudControllerClass.swift
//  SwimmingApp
//
//  Created by Monish M S on 24/09/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

import Foundation
import UIKit
import PKHUD
class hudControllerClass{
    
    class func showNormalHudToViewController(viewController:UIViewController) -> Void {
        HUD.show(.systemActivity)
    }
    
    class func hideHudInViewController(viewController:UIViewController) -> Void {
        HUD.hide()
    }
    class func hideHudInViewControllerForUIView(viewController:UIView) -> Void {
        HUD.hide()
    }
    class func showNormalHudToViewControllerForUIView(viewController:UIView) -> Void {
        HUD.show(.systemActivity)
    }
    
    
}
