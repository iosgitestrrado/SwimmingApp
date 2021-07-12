//
//  LocationSearchVC.swift
//  SwimmingApp
//
//  Created by Monish M S on 18/07/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

import Foundation
import UIKit
class LocationSearchVC:UIViewController,updateLocationProtocol, SelectedChildDetailsDelegate
{
   
    
    
    @IBOutlet var header: CommonHeader!
    @IBOutlet var locationTextField: TextField!
    
    var locationsList = [LocationModel]()
    var id = ""
    var name = ""
    var accessToken = ""
   

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        ServiceCallForLocationList()

        header.profileNameLabel.text = (UserDefaults.standard.value(forKey: "name") as! String)
        
        if UserDefaults.standard.value(forKey: "imgUrl") == nil
        {
            header.imgProfile.sd_setImage(with: URL(string: (UserDefaults.standard.value(forKey: "ProfileImgimgUrl") as! String)), placeholderImage: UIImage(named: "person"))

        }
        
        else
        {
            header.imgProfile.sd_setImage(with: URL(string: (UserDefaults.standard.value(forKey: "imgUrl") as! String)), placeholderImage: UIImage(named: "person"))

        }
        header.backButtonHeight.constant = 0
        header.backButtonWidth.constant = 0
        locationTextField.delegate = self
        header.btnChildPopUp.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)

    }
    func sendSelectedChildDFetailsD(sProfileName: String, sProfileImageName: String, sProfileEmail: String, sProfileMobNumber: String, iSelectedchldId: Int)
    {
        header.profileNameLabel.text = (UserDefaults.standard.value(forKey: "name") as! String)
        header.imgProfile.sd_setImage(with: URL(string: (UserDefaults.standard.value(forKey: "imgUrl") as! String)), placeholderImage: UIImage(named: "person"))
        header.backButtonHeight.constant = 0
        header.backButtonWidth.constant = 0
        locationTextField.delegate = self
        header.btnChildPopUp.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
        ServiceCallForLocationList()
    }
    func locationInfo(id:String,name:String){
        self.tabBarController?.tabBar.isHidden = false
        self.id = id
        self.name = name
        locationTextField.text = name
    }
    @objc func buttonAction(sender: UIButton)
    {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let popupVC = storyBoard.instantiateViewController(withIdentifier: "ChildPopUpViewController") as! ChildPopUpViewController
        popupVC.SelectedChildDetailsDelegate = self
        self.addChild(popupVC)
        self.view.addSubview(popupVC.view)
        popupVC.didMove(toParent: self)

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "locationSearchSegueToExploreListSegue") {
            if let nextViewController = segue.destination as? CourseListVC {
                nextViewController.locationId = id
                nextViewController.accessToken = accessToken
            }
        }
    }
    
    @IBAction func searchButtonTapped(_ sender: Any)
    {
        if locationTextField.text! == ""
        {
           showPopUp(message: "please select a location")
        }
        else
        {
           self.performSegue(withIdentifier: "locationSearchSegueToExploreListSegue", sender: nil)
        }
    }
    
    
    

    
    
}

extension LocationSearchVC{
    func ServiceCallForLocationList(){
       
        if let data = UserDefaults.standard.value(forKey: "userData") as? Data{
            let useObj = try? PropertyListDecoder().decode(UserModel.self,from: data)
            accessToken = (useObj?.access_token)!
        }
        hudControllerClass.showNormalHudToViewController(viewController: self)
        weak var weakSelf = self
        WebServiceApi.locationList(accessToken:accessToken,onSuccess: { (result) in
            
            hudControllerClass.hideHudInViewController(viewController: weakSelf!)
            if let status = result["status"] as? String
            {
                if status == "success"
                {
                    if let dat = result["data"]{
                        do {
                            let jsonData = try JSONSerialization.data(withJSONObject: dat, options: .prettyPrinted)
                            let reqJSONStr = String(data: jsonData, encoding: .utf8)
                            let datas = reqJSONStr?.data(using: .utf8)
                            let jsonDecoder = JSONDecoder()
                            do {
                                let locObj = try jsonDecoder.decode(LocationListModel.self, from: datas!)
                                self.locationsList = locObj.location_list!
                                print("locationListCount=\(self.locationsList.count)")
                            } catch let parseError {
                                print("failed LocationModel decoding = \(parseError.localizedDescription)")
                            }
                        }
                        catch {
                            print("failed Location Model JSON Serialiation")
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
    
    func showPopUp(message:String){
        let alert = AlertController.getSingleOptionAlertControllerWithMessage(message: message, titleOfAlert: "SwimmingApp", oktitle:"Done", OkButtonBlock:{ (action)
            in
            if message == "Invalid access token"
            {
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = mainStoryboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                UIApplication.shared.keyWindow?.rootViewController = viewController
            }
        })
        self.present(alert,animated: false,completion: nil)
    }
}
extension LocationSearchVC:UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        let storyBoard = UIStoryboard(name: "Common", bundle: nil)
        let popupVC = storyBoard.instantiateViewController(withIdentifier: "LocationSearchBarVC") as! LocationSearchBarVC
        
        popupVC.delegate = self
        popupVC.locationList = locationsList
        self.addChild(popupVC)
        self.view.addSubview(popupVC.view)
        popupVC.didMove(toParent: self)
    }
}
