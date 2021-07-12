//
//  RegistrationYourSelfVC.swift
//  SwimmingApp
//
//  Created by Monish M S on 18/07/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

import Foundation
import UIKit
class RegistrationYourSelfVC:UIViewController{
    
    @IBOutlet var emailAdressTextField: TextField!
    @IBOutlet var continueButton: ShadowButton!
    @IBOutlet var mobileNumberTextField: TextField!
    @IBOutlet var closeButton: UIImageView!
    
    var name:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.setUPBackGroundImage(mainView: self.view, image: UIImage(named: "register_urself_00")!)
        setupGestures()
        
    }
    
    func setupGestures(){
        let closeButtonGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(closeButtonTapped(tapGestureRecognizer:)))
        closeButton.isUserInteractionEnabled = true
        closeButton.addGestureRecognizer(closeButtonGestureRecognizer)
    }
    
    @objc func closeButtonTapped(tapGestureRecognizer: UITapGestureRecognizer){
        self.dismiss(animated: false, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segueToRegistrationOTPVC") {
            if let nextViewController = segue.destination as? RegistrationYourselfOTPVC {
                nextViewController.mobile = mobileNumberTextField.text!
                nextViewController.otpType = "register"
            }
        }
    }
    
    @IBAction func continueButtonTapped(_ sender: Any) {
        if emailAdressTextField.text! == ""{
            showPopUp(message: "Please enter email address")
        }else if !Validation.isValidEmail(testStr: emailAdressTextField.text!){
            showPopUp(message: "please enter valid email address")
        }else if mobileNumberTextField.text! == ""{
            showPopUp(message: "Please enter mobile number")
        }else{
            serviceCallForRegistration()
        }
    }
    
}

extension RegistrationYourSelfVC{
    func serviceCallForRegistration(){
        hudControllerClass.showNormalHudToViewController(viewController: self)
        weak var weakSelf = self
        WebServiceApi.registerUser(name:name,phone:mobileNumberTextField.text!,email:emailAdressTextField.text!,onSuccess: { (result) in
            
            hudControllerClass.hideHudInViewController(viewController: weakSelf!)
            
            if let status = result["status"] as? String {
                if status == "success"{
                    self.performSegue(withIdentifier: "segueToRegistrationOTPVC", sender: nil)
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


