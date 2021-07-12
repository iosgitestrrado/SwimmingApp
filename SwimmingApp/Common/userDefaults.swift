//
//  userDefaults.swift
//  SwimmingApp
//
//  Created by Monish M S on 20/09/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

import Foundation
import UIKit

public class userDefaults
{
    
    // MARK: - USERDEFAULTSVALUE
    
    
    
    class func SET_USERDEFAULTS(user_language:String,objectValue:String){
        UserDefaults.standard.setValue(user_language, forKeyPath: objectValue)
        UserDefaults.standard.synchronize()
    }
    class func GET_USERDEFAULTS(objectValue:String) -> String{
        var user_id:String = ""
        if (UserDefaults.standard.value(forKey: objectValue) != nil){
            user_id = UserDefaults.standard.value(forKey: objectValue) as! String
        }
        return user_id
    }
    class func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
    
    
    
    // MARK: - USERDEFAULTSSTATUS [True] or [False]
    
    
    
    class func SET_USERDEFAULTS(user_language:Bool,objectValue:String){
        UserDefaults.standard.set(user_language, forKey: objectValue)
        UserDefaults.standard.synchronize()
    }
    class func GET_USERDEFAULTSSTATUS(objectValue:String) -> Bool{
        var user_status:Bool = false
        if (UserDefaults.standard.value(forKey: objectValue) != nil){
            user_status = UserDefaults.standard.value(forKey: objectValue) as! Bool
        }
        return user_status
    }
    
    
}
