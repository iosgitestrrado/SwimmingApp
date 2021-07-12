//
//  RegisterChildVC.swift
//  SwimmingApp
//
//  Created by Monish M S on 18/07/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

import Foundation
import UIKit
class RegisterChildVC:UIViewController,relationshipsProtocol{
    
    @IBOutlet var rootStackView: UIStackView!
    @IBOutlet var cancelButton: UIImageView!
    @IBOutlet var progressView: BorderProgressBar!
    @IBOutlet var tempButton: UIButton!
    
    
    var addButtonList = [UIButton]()
    var submitButtonList = [UIButton]()
    var relationTextFieldList = [UITextField]()
    var position:Int = 0
    var tagVal:Int = 0
    var relationsList = [relationshipsModel]()
    var childViewList = [childSubView]()
    var childModelList = [childModel]()
    var childList = [[String : AnyObject]]()
    var a = NSMutableArray()
    var mobile:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.setUPBackGroundImage(mainView: self.view, image: UIImage(named: "register_child")!)
        setupGestures()
        setupUI()
        serviceCallForRelationsList()
    }
    
    func setupGestures(){
        let closeButtonGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(closeButtonTapped(tapGestureRecognizer:)))
        cancelButton.isUserInteractionEnabled = true
        cancelButton.addGestureRecognizer(closeButtonGestureRecognizer)
    }
    
    @objc func closeButtonTapped(tapGestureRecognizer: UITapGestureRecognizer){
        self.dismiss(animated: false, completion: nil)
    }
    
    func setupUI(){
        print("position===\(position)")
        tempButton.isHidden = true
        let childView = childSubView.instanceFromNib() as! childSubView
        
        let childBottomView = childBottomButtonView.instanceFromNib() as! childBottomButtonView
        addButtonList.append(childBottomView.addButton)
        submitButtonList.append(childBottomView.submitButton)
        relationTextFieldList.append(childView.guardianRelationTextField)
        
        childView.guardianRelationTextField.delegate = self
        childView.guardianRelationTextField.tag = position
        childBottomView.addButton.addTarget(self, action: #selector(self.addButtonTapped(_:)), for: .touchUpInside)
        childBottomView.submitButton.addTarget(self, action: #selector(self.submitButtonTapped(_:)), for: .touchUpInside)
        
        
        childViewList.append(childView)
        rootStackView.addArrangedSubview(childView)
        rootStackView.addArrangedSubview(childBottomView)
        self.view.layoutIfNeeded()
    }
    
    @objc func addButtonTapped(_ button:UIButton) {
        addButtonList[position].isHidden = true
        submitButtonList[position].isHidden = true
        position = position + 1
        setupUI()
        
    }
    
    @objc func submitButtonTapped(_ button:UIButton) {
        childList.removeAll()
        a.removeAllObjects()
        for i in 0 ..< childViewList.count{
            var id:String = ""
            
            for j in 0 ..< relationsList.count{
                if relationsList[j].relation == childViewList[i].guardianRelationTextField.text!{
                    id = String(relationsList[j].id)
                }
            }
            //let obj = childModel(name: childViewList[i].childNameTextField.text!, phone: childViewList[i].guardianMobileNumberTextField.text!, email: childViewList[i].guardianEmailIdTextField.text!, relation: id)
            let obj = childModel(name: childViewList[i].childNameTextField.text!, phone: childViewList[i].guardianMobileNumberTextField.text!, email: childViewList[i].guardianEmailIdTextField.text!, relation: id)
            let userDict = obj.dictionaryRepresentation
            childList.append(userDict as [String : AnyObject])
           
            a.add(userDict)
            
            
        }
        serviceCallForAddNewChild()
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        appDelegate.settabbarRootVC()
    }
    
    func relationshipsResponse(val:String){
        childViewList[tagVal].guardianRelationTextField.text = val
    }
}
extension RegisterChildVC{
    func serviceCallForRelationsList(){
        hudControllerClass.showNormalHudToViewController(viewController: self)
        weak var weakSelf = self
        WebServiceApi.relationshipList(onSuccess: { (result) in
            
            hudControllerClass.hideHudInViewController(viewController: weakSelf!)
            
            if let status = result["status"] as? String {
                if status == "success"{
                    if let dat = result["data"]{
                        do {
                            let jsonData = try JSONSerialization.data(withJSONObject: dat, options: .prettyPrinted)
                            let reqJSONStr = String(data: jsonData, encoding: .utf8)
                            let datas = reqJSONStr?.data(using: .utf8)
                            let jsonDecoder = JSONDecoder()
                            do {
                                let relObj = try jsonDecoder.decode(RelationshipModel.self, from: datas!)
                                self.relationsList = relObj.relationships!
                                } catch let parseError {
                                print("failed RelationshipModel decoding = \(parseError.localizedDescription)")
                            }
                        }
                        catch {
                            print("failed relationship Model JSON Serialiation")
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
    
    func serviceCallForAddNewChild(){
        hudControllerClass.showNormalHudToViewController(viewController: self)
        weak var weakSelf = self
        WebServiceApi.addNewChild(mobile:mobile, childModelList: childList,onSuccess: { (result) in
            
            hudControllerClass.hideHudInViewController(viewController: weakSelf!)
            
            if let status = result["status"] as? String {
                if status == "success"{
                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let viewController = mainStoryboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                    UIApplication.shared.keyWindow?.rootViewController = viewController
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

extension RegisterChildVC:UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        childViewList[textField.tag].guardianRelationTextField.resignFirstResponder()
        let storyBoard = UIStoryboard(name: "Common", bundle: nil)
        let popupVC = storyBoard.instantiateViewController(withIdentifier: "RelationshipsPopupVC") as! RelationshipsPopupVC
        popupVC.relationsList = relationsList
        tagVal = textField.tag
        popupVC.delegate = self
        self.addChild(popupVC)
        self.view.addSubview(popupVC.view)
        popupVC.didMove(toParent: self)
        print("tapped\(textField.tag)")
    }
}
