//
//  AlertController.swift
//  SwimmingApp
//
//  Created by Monish M S on 24/09/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

import Foundation
import UIKit



class AlertController{
    
    
    
    class func getTwoOptionAlertControllerWithMessage (message:String, titleOfAlert title:String,  oktitle okbuttontitle:String,cancelTitle cancelButtontitle:String,cancelButtonBlock cancelHandler:((UIAlertAction) -> Void)?,OkButtonBlock OKhandler: ((UIAlertAction) -> Void)?) ->UIAlertController{
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: cancelButtontitle, style: UIAlertAction.Style.cancel, handler: cancelHandler))
        alert.addAction(UIAlertAction(title: okbuttontitle, style: UIAlertAction.Style.default, handler: OKhandler))
        return alert
    }
    
    class func getSingleOptionAlertControllerWithMessage (message:String, titleOfAlert title:String,  oktitle okbuttontitle:String,OkButtonBlock OKhandler: ((UIAlertAction) -> Void)?) ->UIAlertController{
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: okbuttontitle, style: UIAlertAction.Style.default, handler: OKhandler))
        return alert
    }
    
    
}
