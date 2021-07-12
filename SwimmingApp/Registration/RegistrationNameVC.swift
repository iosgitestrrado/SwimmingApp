//
//  RegistrationNameVC.swift
//  SwimmingApp
//
//  Created by Monish M S on 18/07/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

import Foundation
import UIKit
class RegistrationNameVC:UIViewController{
    
    @IBOutlet var progressBar: UIProgressView!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var continueButton: UIButton!
    @IBOutlet var closeButton: UIImageView!
    
    let color = UIColor(red: 210.0/255.0, green: 210.0/255.0, blue: 210.0/255.0, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.setUPBackGroundImage(mainView: self.view, image: UIImage(named: "register_00")!)
        let yourSelfGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(closeButtonTapped))
        closeButton.isUserInteractionEnabled = true
        closeButton.addGestureRecognizer(yourSelfGestureRecognizer)
    }
    
    @objc func closeButtonTapped(tapGestureRecognizer: UITapGestureRecognizer){
        self.dismiss(animated: false, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showSegueToRegisterYourselfVC") {
            if let nextViewController = segue.destination as? RegistrationYourSelfVC {
                nextViewController.name = nameTextField.text!
            }
        }
    }
    
    
    @IBAction func continueButtonTapped(_ sender: Any) {
        if nameTextField.text == ""{
            showPopUp(message: "Please enter name")
        }else{
            self.performSegue(withIdentifier: "showSegueToRegisterYourselfVC", sender: nil)
        }
    }
    
    func showPopUp(message:String){
        let alert = AlertController.getSingleOptionAlertControllerWithMessage(message: message, titleOfAlert: "SwimmingApp", oktitle:"Done", OkButtonBlock:{ (action)
            in
        })
        self.present(alert,animated: false,completion: nil)
    }
}

