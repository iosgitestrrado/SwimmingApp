//
//  RegistrationYourselfOTPVC.swift
//  SwimmingApp
//
//  Created by Monish M S on 18/07/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

import Foundation
import UIKit
class RegistrationYourselfOTPVC:UIViewController{
    
    
    @IBOutlet var firstOtpTextField: TextField!
    @IBOutlet var secondOtpTextField: TextField!
    @IBOutlet var thirdOtpTextField: TextField!
    @IBOutlet var fourthOtpTextField: TextField!
    @IBOutlet var cancelButton: UIImageView!
    var sTopBarCourseArray = [String] ()
    var sTopBarcourse_codeArray = [String] ()

    var topBarCourseIds = [Int]()
    var topBarCourse_course_ids = [Int]()
    var course_listModelData : [courseModelData]?
    var mobile:String = ""
    var otpType:String = ""
    var accessToken = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.setUPBackGroundImage(mainView: self.view, image: UIImage(named: "register_urself_01")!)
        setupGestures()
        setupOTPTextFields()
    }
    
    func setupGestures(){
        let closeButtonGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(closeButtonTapped(tapGestureRecognizer:)))
        cancelButton.isUserInteractionEnabled = true
        cancelButton.addGestureRecognizer(closeButtonGestureRecognizer)
    }
    
    func setupOTPTextFields(){
        firstOtpTextField.delegate = self
        secondOtpTextField.delegate = self
        thirdOtpTextField.delegate = self
        fourthOtpTextField.delegate = self
        
        firstOtpTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        secondOtpTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        thirdOtpTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        fourthOtpTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }
    
    @objc func closeButtonTapped(tapGestureRecognizer: UITapGestureRecognizer){
        self.dismiss(animated: false, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segueToRegisterYourself") {
            if let nextViewController = segue.destination as? RegistrationOptionVC {
                nextViewController.mobile = mobile
            }
        }
    }
    
    @IBAction func continueButtonTapped(_ sender: Any) {
        if firstOtpTextField.text! == "",secondOtpTextField.text! == "",thirdOtpTextField.text! == "" || fourthOtpTextField.text! == ""{
           showPopUp(message: "Please enter valid OTP")
        }else{
            serviceCallForOTPVerification()
            //self.performSegue(withIdentifier: "segueToRegisterYourself", sender: nil)
        }
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        appDelegate.settabbarRootVC()
    }
    
    @IBAction func resendOtpButtonTapped(_ sender: Any) {
       serviceCallForResendOTP()
    }
    
}

extension RegistrationYourselfOTPVC:UITextFieldDelegate{
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        let text = textField.text
        
        if text!.utf16.count >= 1{
            switch textField{
            case firstOtpTextField:
                secondOtpTextField.becomeFirstResponder()
            case secondOtpTextField:
                thirdOtpTextField.becomeFirstResponder()
            case thirdOtpTextField:
                fourthOtpTextField.becomeFirstResponder()
            case fourthOtpTextField:
                fourthOtpTextField.resignFirstResponder()
            default:
                break
            }
        }else{
            
        }

    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        if updatedText.count == 1{
            textField.text = ""
        }
        return updatedText.count <= 1
    }
    
}

extension RegistrationYourselfOTPVC{
    func serviceCallForOTPVerification(){
        var deviceToken = ""
        let str = "\(firstOtpTextField.text!)\(secondOtpTextField.text!)\(thirdOtpTextField.text!)\(fourthOtpTextField.text!)"
        print("otp is ==\(str)")
        if self.otpType == "login"
        {
            deviceToken = userDefaults.GET_USERDEFAULTS(objectValue: "fcmToken")
        }
        hudControllerClass.showNormalHudToViewController(viewController: self)
        weak var weakSelf = self
        WebServiceApi.OTPVerification(mobile:mobile, otp: str, type: otpType, deviceToken: deviceToken, OS: "ios",onSuccess: { [self] (result) in
            
            hudControllerClass.hideHudInViewController(viewController: weakSelf!)
            
            if let status = result["status"] as? String
            {
                if status == "success"
                {
                    if let Message = result["message"] as? String
                    {
//                        self.showPopUpSuccess(message:Message,result: result)
                        
                        if self.otpType == "login"
                        {
                            if let dat = result["data"]
                            {
                                let data1 = dat.object(forKey: "userDetails") as! NSDictionary
                                
                                do {
                                    let jsonData = try JSONSerialization.data(withJSONObject: dat, options: .prettyPrinted)
                                    let reqJSONStr = String(data: jsonData, encoding: .utf8)
                                    let datas = reqJSONStr?.data(using: .utf8)
                                    let jsonDecoder = JSONDecoder()
                                    do {
                                        let userObj = try jsonDecoder.decode(userDetailsModel.self, from: datas!)
                                        UserDefaults.standard.setValue(data1.object(forKey: "name"), forKey: "name")
                                        
                                        UserDefaults.standard.setValue(data1.object(forKey: "email"), forKey: "email")
                                        UserDefaults.standard.setValue(self.mobile, forKey: "mobile")
                                        
                                        self.accessToken = userObj.userDetails.access_token!

                                        var imgUrl = data1.object(forKey: "avthar") as! String
                                         imgUrl = imgUrl.replacingOccurrences(of: "https://estrradoweb.com/swimming/storage", with: "")

                                        let singleLineString = "https://estrradoweb.com/swimming/storage"
                                        imgUrl = singleLineString + imgUrl
                                        
                                        
                                        UserDefaults.standard.setValue(imgUrl, forKey: "ProfileImgimgUrl")

                                        self.GetProfiledetails()
                                        
                                        UserDefaults.standard.set(try? PropertyListEncoder().encode(userObj.userDetails), forKey: "userData")
            //                            if let data = UserDefaults.standard.value(forKey: "userData") as? Data{
            //                                let useObj = try? PropertyListDecoder().decode(UserModel.self,from: data)
            //                                print("userObject====\(useObj?.name)")
            //                            }
                                    } catch let parseError {
                                        print("failed UserModel decoding = \(parseError.localizedDescription)")
                                    }
                                }
                                catch {
                                    print("failed user Model JSON Serialiation")
                                }
                            }
                            
                        }
                        else
                        {
                            self.performSegue(withIdentifier: "segueToRegisterYourself", sender: nil)
                        }
                    }
                }else{
                    if let errorMessage = result["message"] as? String
                    {
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
    
    func serviceCallForResendOTP(){
        hudControllerClass.showNormalHudToViewController(viewController: self)
        weak var weakSelf = self
        WebServiceApi.resendOTP(mobile:mobile,type: otpType,onSuccess: { (result) in
            
            hudControllerClass.hideHudInViewController(viewController: weakSelf!)
            
            if let status = result["status"] as? String {
                if status == "success"{
                    
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
    
    func showPopUpSuccess(message:String,result:Dictionary<String, AnyObject>){
        let alert = AlertController.getSingleOptionAlertControllerWithMessage(message: message, titleOfAlert: "SwimmingApp", oktitle:"Done", OkButtonBlock:{ [self] (action)
            in
//            if self.otpType == "login"
//            {
//                if let dat = result["data"]
//                {
//                    let data1 = dat.object(forKey: "userDetails") as! NSDictionary
//
//                    do {
//                        let jsonData = try JSONSerialization.data(withJSONObject: dat, options: .prettyPrinted)
//                        let reqJSONStr = String(data: jsonData, encoding: .utf8)
//                        let datas = reqJSONStr?.data(using: .utf8)
//                        let jsonDecoder = JSONDecoder()
//                        do {
//                            let userObj = try jsonDecoder.decode(userDetailsModel.self, from: datas!)
//                            UserDefaults.standard.setValue(data1.object(forKey: "name"), forKey: "name")
//
//                            UserDefaults.standard.setValue(data1.object(forKey: "email"), forKey: "email")
//                            UserDefaults.standard.setValue(self.mobile, forKey: "mobile")
//
//                            accessToken = userObj.userDetails.access_token!
//
//                            var imgUrl = data1.object(forKey: "avthar") as! String
//                             imgUrl = imgUrl.replacingOccurrences(of: "https://estrradoweb.com/swimming/storage", with: "")
//
//                            let singleLineString = "https://estrradoweb.com/swimming/storage"
//                            imgUrl = singleLineString + imgUrl
//
//                            UserDefaults.standard.setValue(imgUrl, forKey: "imgUrl")
//                            self.GetProfiledetails()
//
//                            UserDefaults.standard.set(try? PropertyListEncoder().encode(userObj.userDetails), forKey: "userData")
////                            if let data = UserDefaults.standard.value(forKey: "userData") as? Data{
////                                let useObj = try? PropertyListDecoder().decode(UserModel.self,from: data)
////                                print("userObject====\(useObj?.name)")
////                            }
//                        } catch let parseError {
//                            print("failed UserModel decoding = \(parseError.localizedDescription)")
//                        }
//                    }
//                    catch {
//                        print("failed user Model JSON Serialiation")
//                    }
//                }
//                userDefaults.SET_USERDEFAULTS(user_language: true, objectValue: "isLoggedIn")
//                let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                appDelegate.settabbarRootVC()
//            }
//            else
//            {
//                self.performSegue(withIdentifier: "segueToRegisterYourself", sender: nil)
//            }
        })
        self.present(alert,animated: false,completion: nil)
    }
    
    
    
    
    
    func GetProfiledetails()
    {
       
        if let data = UserDefaults.standard.value(forKey: "userData") as? Data{
            let useObj = try? PropertyListDecoder().decode(UserModel.self,from: data)
            accessToken = (useObj?.access_token)!
        }
        hudControllerClass.showNormalHudToViewController(viewController: self)
        weak var weakSelf = self
        WebServiceApi.ProfileApi(accesToken:accessToken,onSuccess: { [self] (result) in
            
            hudControllerClass.hideHudInViewController(viewController: weakSelf!)
            if let status = result["status"] as? String
            {
                if status == "success"
                {
                    if let dat = result["data"]
                    {
                        
                        let dict1 = result["data"] as! NSDictionary
                        
                        let dict2 = dict1.object(forKey: "childrens") as! Array<Any>
                        
                        
                        let dict3 = dict2[0] as! NSDictionary
                        

                        let child_ImgUrl = dict3.object(forKey: "avthar")
                        
                        UserDefaults.standard.setValue(child_ImgUrl, forKey: "imgUrl")

                        UserDefaults.standard.setValue("", forKey: "")
                        
                        let child_id = dict3.object(forKey: "id") as! Int

                        
                        UserDefaults.standard.setValue(String(child_id), forKey: "Child_id")
                        
                        self.GetCourseListData()
                        
                        

                    }
                }
                else
                {
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
    
    
    
    func GetCourseListData()
    {
       
        if let data = UserDefaults.standard.value(forKey: "userData") as? Data{
            let useObj = try? PropertyListDecoder().decode(UserModel.self,from: data)
            accessToken = (useObj?.access_token)!
        }
        weak var weakSelf = self
        
        var sChildId = "0"
        sChildId = UserDefaults.standard.value(forKey: "Child_id") as! String


        WebServiceApi.MyCoursesApi(accesToken: accessToken, child_id: sChildId as! String,onSuccess: { [self] (result) in
            
            hudControllerClass.hideHudInViewController(viewController: weakSelf!)
            if let status = result["status"] as? String
            {
                if status == "success"
                {
                    if let dat = result["data"]
                    {
                        do {
                            let jsonData = try JSONSerialization.data(withJSONObject: dat, options: .prettyPrinted)
                            let reqJSONStr = String(data: jsonData, encoding: .utf8)
                            let datas = reqJSONStr?.data(using: .utf8)
                            let jsonDecoder = JSONDecoder()
                            do
                                                     {
                                                         let jsonData = try JSONSerialization.data(withJSONObject: dat, options: .prettyPrinted)
                                                         let reqJSONStr = String(data: jsonData, encoding: .utf8)
                                                         let datas = reqJSONStr?.data(using: .utf8)
                                                         let jsonDecoder = JSONDecoder()
                                                         do {
                                                            
                                                            let locObj = try jsonDecoder.decode(course_listModel.self, from: datas!)
                                                            print(locObj.course_list.count)
                                                            course_listModelData = locObj.course_list
                                                            
                                                            for Coursedata in self.course_listModelData!
                                                                {
                                                                self.sTopBarCourseArray.append(Coursedata.course_name!)
                                                                self.topBarCourseIds.append(Coursedata.id)
                                                                self.topBarCourse_course_ids.append(Coursedata.course_id!)
                                                                self.sTopBarcourse_codeArray.append(Coursedata.course_code!)
                                                                }
                                                            
                                                            UserDefaults.standard.setValue(self.sTopBarCourseArray, forKey: "CourseArray")
                                                            
                                                            UserDefaults.standard.setValue(self.sTopBarCourseArray, forKey: "course_codeArray")

                                                            UserDefaults.standard.setValue(self.topBarCourseIds, forKey: "Course_Primary_Id")
                                                            
                                                            UserDefaults.standard.setValue(self.topBarCourse_course_ids, forKey: "Course_Course_Id")

                                                            userDefaults.SET_USERDEFAULTS(user_language: true, objectValue: "isLoggedIn")
                                                            let appDelegate = UIApplication.shared.delegate as! AppDelegate
                                                            appDelegate.settabbarRootVC()
                                                         }
                                                         catch let parseError
                                                         {
                                                             print("failed course_list decoding = \(parseError.localizedDescription)")
                                                         }
                                                     }
                            catch let parseError
                            {
                                print("failed course_list decoding = \(parseError.localizedDescription)")
                            }
                        }
                        catch {
                            print("failed course_list Model JSON Serialiation")
                        }
                    }
                }
                else
                {
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
    
    
}
