//
//  HelperLibrary.swift
//  SwimmingApp
//
//  Created by Monish M S on 23/09/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

import Foundation
class HelperLibrary {
    
    // helper function to delay whatever's in the callback
    class func delay(seconds: Double, completion:()->()) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            print("Runs Aysnc in 5 seconds later")
        }
    }
    
}
