//
//  StepTwo.swift
//  SwimmingApp
//
//  Created by Monish M S on 23/09/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

import Foundation
import UIKit

class StepTwo : UIViewController {
    override func viewWillAppear(_ animated: Bool) {
        // reset animation to starting point
        // so user can scroll back and re-watch.
//        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
//        statusBar.isHidden = true
        
        // this hacky delay is so the screen gets its stuff in order before we start animating.
        // otherwise the entire screen starts morphing in strange ways.
        HelperLibrary.delay(seconds: 0.5, completion: {
            
            // burger goes up
            // not meant to be precise like newton's law
            UIView.animate(withDuration: 0.5,
                           delay: 0.0,
                           options: .curveEaseOut,
                           animations: {
                            // constraints don't get animated by default, so you need layoutIfNeeded()
                            
                            self.view.layoutIfNeeded()
                           
                           
            },
                           completion: nil
            )
            
            // burger goes down
            UIView.animate(withDuration: 0.5,
                           delay: 0.5,
                           options: .curveEaseIn,
                           animations: {
                            // again, using layoutIfNeeded() for animating constraints
                           
                            self.view.layoutIfNeeded()
                            // flip the tofu
                           
            },
                           completion: nil
            )
            
        })
    }
    
   
    
    @IBAction func skipButtonTapped(_ sender: Any) {
        userDefaults.SET_USERDEFAULTS(user_language: true, objectValue: "splashScreenSkipped")
        serviceCallForForceUpdate()
    }
    
    func navigationToLoginVC()
    {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        UIApplication.shared.keyWindow?.rootViewController = viewController
    }
    
}

extension StepTwo{
    func serviceCallForForceUpdate(){
        hudControllerClass.showNormalHudToViewController(viewController: self)
        weak var weakSelf = self
        WebServiceApi.versionInfo(onSuccess: { (result) in
            
            hudControllerClass.hideHudInViewController(viewController: weakSelf!)
            
            if let status = result["status"] as? String {
                if status == "success"{
                    if let dat = result["data"]{
                        if let ver = dat["version"] as? String{
                            let appVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String
                            if ver != appVersion{
                                let alert = AlertController.getSingleOptionAlertControllerWithMessage(message: "There is a newer version avaiable for download! Please update the app by visiting the Apple Store", titleOfAlert: "New Version Available", oktitle: "OK", OkButtonBlock:{ (action)
                                    in
//                                    let url  = URL(string: "itms-apps://itunes.apple.com/app/id1463775559")
//                                    if UIApplication.shared.canOpenURL(url!) {
//                                        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
//                                    }
                                })
                                self.present(alert,animated: false,completion: nil)
                            }else{
                                self.navigationToLoginVC()
                            }
                        }
                    }
                }else{
                    if let errorMessage = result["message"] as? String {
                        self.showPopUp(message:errorMessage)
                    }
                }
            }
            
        }, onFailure: { (error) in
            hudControllerClass.hideHudInViewController(viewController: weakSelf!)
            if error.localizedDescription == ConstantsInUI.noInternet{
                self.showPopUp(message: ConstantsInUI.noInternet)
            }else{
                self.showPopUp(message: ConstantsInUI.serverConnectionFail)
            }
        }, duringProgress: nil)
    }
    
    func showPopUp(message:String){
        let alert = AlertController.getSingleOptionAlertControllerWithMessage(message: message, titleOfAlert: "SwimmingApp", oktitle:"Done", OkButtonBlock:{ (action)
            in
        })
        self.present(alert,animated: false,completion: nil)
    }
}

