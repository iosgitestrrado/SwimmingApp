//
//  StepOne.swift
//  SwimmingApp
//
//  Created by Monish M S on 23/09/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

import UIKit
class StepOne : UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    override func viewWillAppear(_ animated: Bool) {
        // reset animation to starting point
        // so user can scroll back and re-watch.
        // these numbers are pure trial and error, and might not work for other screens.
        
       
        imageView?.transform = CGAffineTransform(rotationAngle: 0)
        
        // this hacky delay is so the screen gets its stuff in order before we start animating.
        // otherwise the entire screen starts morphing in strange ways.
        HelperLibrary.delay(seconds: 1.0, completion: {
            
            // vertical animation of the tofu dropping.
            // not meant to be precise like newton's law
            UIView.animate(withDuration: 1.0,
                           delay: 0.0,
                           options: .curveEaseIn,
                           animations: {
                            // constraints don't get animated by default, so you need layoutIfNeeded()
                            
                            self.view.layoutIfNeeded()
            },
                           completion: nil
            )
            
            // horizontal animation is twice as fast.
            // gotta get to tofu over the can before it drops too far.
            UIView.animate(withDuration: 0.5,
                           delay: 0.0,
                           options: .curveLinear,
                           animations: {
                            // again, using layoutIfNeeded() for animating constraints
                           
                            self.view.layoutIfNeeded()
                            // flip the tofu
                            self.imageView?.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI))
            },
                           completion: nil
            )
            
        })
        
    }
    
}


