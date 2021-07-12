//
//  RegistrationOptionVC.swift
//  SwimmingApp
//
//  Created by Monish M S on 18/07/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

import Foundation
import UIKit
class RegistrationOptionVC:UIViewController{
    
    @IBOutlet var yourSelfView: UIView!
    @IBOutlet var childView: UIView!
    @IBOutlet var yourSelfImageView: UIImageView!
    @IBOutlet var childImageView: UIImageView!
    @IBOutlet var closeButton: UIImageView!
    
    let color = UIColor(red: 210.0/255.0, green: 210.0/255.0, blue: 210.0/255.0, alpha: 1.0)
    var mobile:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.setUPBackGroundImage(mainView: self.view, image: UIImage(named: "register_01")!)
        setupGestures()
    }
    
    func setupGestures(){
        let yourSelfGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(yourSelfButtonTapped))
        yourSelfView.addGestureRecognizer(yourSelfGestureRecognizer)
        let childGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(childButtonTapped))
        childView.addGestureRecognizer(childGestureRecognizer)
        
        let closeButtonGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(closeButtonTapped(tapGestureRecognizer:)))
        closeButton.isUserInteractionEnabled = true
        closeButton.addGestureRecognizer(closeButtonGestureRecognizer)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showSegueToRegisterChildVC") {
            if let nextViewController = segue.destination as? RegisterChildVC {
                nextViewController.mobile = mobile
            }
        }
    }
    
    @objc func yourSelfButtonTapped(){
        ServiceCallForAddUserType(tag: "0")
    }
    
    @objc func childButtonTapped(){
        ServiceCallForAddUserType(tag: "1")
    }
    
    @objc func closeButtonTapped(tapGestureRecognizer: UITapGestureRecognizer){
        self.dismiss(animated: false, completion: nil)
    }
}

extension RegistrationOptionVC{
    func ServiceCallForAddUserType(tag:String){
        hudControllerClass.showNormalHudToViewController(viewController: self)
        weak var weakSelf = self
        WebServiceApi.addUserType(mobile:mobile, type: tag,onSuccess: { (result) in
            
            hudControllerClass.hideHudInViewController(viewController: weakSelf!)
            
            if let status = result["status"] as? String {
                if status == "success"{
                    if let data = result["data"]{
                        if let msg = data["message"] as? String{
                            self.showPopUpSuccess(message: msg, tag: tag)
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
    
    func showPopUpSuccess(message:String,tag:String){
        let alert = AlertController.getSingleOptionAlertControllerWithMessage(message: message, titleOfAlert: "SwimmingApp", oktitle:"Done", OkButtonBlock:{ (action)
            in
            if tag == "0"{
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = mainStoryboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                UIApplication.shared.keyWindow?.rootViewController = viewController
            }else{
                self.performSegue(withIdentifier: "showSegueToRegisterChildVC", sender: nil)
            }
        })
        self.present(alert,animated: false,completion: nil)
    }
}

