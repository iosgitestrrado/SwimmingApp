//
//  LoginVC.swift
//  SwimmingApp
//
//  Created by Monish M S on 23/09/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

import Foundation
import UIKit
class LoginVC:UIViewController{
    
    @IBOutlet var signUpLabel: UILabel!
    @IBOutlet var mobileNumberTextField: TextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.setUPBackGroundImage(mainView: self.view, image: UIImage(named: "login")!)
        setupLabel()
    }
    
    func setupLabel(){
        let boldText  = " SIGN UP"
        let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15)]
        let attributedString = NSMutableAttributedString(string:boldText, attributes:attrs)
        
        let normalText = "Don't have an account?"
        let normalString = NSMutableAttributedString(string:normalText)
        
        normalString.append(attributedString)
        signUpLabel.attributedText = normalString
        let gesture = UITapGestureRecognizer(target: self, action: #selector(signUpLabelTapped))
        signUpLabel.isUserInteractionEnabled = true
        signUpLabel.addGestureRecognizer(gesture)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "loginToRegistrationOTPVCScene") {
            if let nextViewController = segue.destination as? RegistrationYourselfOTPVC {
                nextViewController.mobile = mobileNumberTextField.text!
                nextViewController.otpType = "login"
            }
        }
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        if mobileNumberTextField.text! == ""{
            showPopUp(message: "Please enter mobile number")
        }else{
            serviceCallForLogin()
        }
        
    }
    
    @objc func signUpLabelTapped(){
        self.performSegue(withIdentifier: "loginToRegisterNameSegue", sender: nil)
    }
}

extension LoginVC{
    func serviceCallForLogin(){
        hudControllerClass.showNormalHudToViewController(viewController: self)
        weak var weakSelf = self
        WebServiceApi.loginSubmission(mobile:mobileNumberTextField.text!,onSuccess: { (result) in
            
            hudControllerClass.hideHudInViewController(viewController: weakSelf!)
            
            if let status = result["status"] as? String {
                if status == "success"{
                     self.performSegue(withIdentifier: "loginToRegistrationOTPVCScene", sender: nil)
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

extension String
{
    var isNumber: Bool
    {
        let characters = CharacterSet.decimalDigits.inverted
        return !self.isEmpty && rangeOfCharacter(from: characters) == nil
    }
    
    var isValidEmail: Bool
    {
        NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self)
    }
    
   
}
extension UIViewController
{
    // MARK: show Alert
      
    func showToast(message : String) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height/2, width: self.view.frame.size.width, height: 70))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        //toastLabel.font = font
        toastLabel.center = self.view.center
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        //toastLabel.sizeToFit()
        toastLabel.numberOfLines = 0
        self.view.addSubview(toastLabel)
        
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}
