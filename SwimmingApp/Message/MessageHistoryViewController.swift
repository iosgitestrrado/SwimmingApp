//
//  MessageHistoryViewController.swift
//  SwimmingApp
//
//  Created by MAC on 17/10/20.
//  Copyright © 2020 Monish M S. All rights reserved.
//

import UIKit
import SDWebImage
class MessageHistoryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource

{
    
//    @IBOutlet var header: CommonHeader!

    @IBOutlet weak var btnSendMessage: UIButton!
    @IBOutlet weak var txtInputMessage: UITextField!
    @IBOutlet weak var tblMessageHistory: UITableView!
    
    var accessToken = ""
    var chat_id = ""
    var coach_id = ""
    var chat_msg = ""
    var sChatAdminImageUrl = ""
    var dict1Data = NSDictionary()
    var dictchat_data = NSDictionary()
    var arrchat_messages = Array<Any>()
    var dictchat_Messagesdata = NSDictionary()

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.GetchatHistory()

    }
    
    @IBAction func ActionSendMessage(_ sender: Any)
    {
        self.SaveMessages()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrchat_messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        dictchat_Messagesdata = arrchat_messages[indexPath.row] as! NSDictionary
        if dictchat_Messagesdata.object(forKey: "from") as! String == "You"
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserChatTableViewCell", for: indexPath) as!
                UserChatTableViewCell
            
            cell.lblUserdate.text = (dictchat_Messagesdata.object(forKey: "date") as! String)
            cell.lblUserTime.text = (dictchat_Messagesdata.object(forKey: "time") as! String)
            cell.txtMessage.text = (dictchat_Messagesdata.object(forKey: "message") as! String)
            cell.imgUser.layer.borderWidth = 2.0
            cell.imgUser.layer.borderColor = UIColor.green.cgColor

            return cell

        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AdminChatTableViewCell", for: indexPath) as! AdminChatTableViewCell
            cell.lblAdminDate.text = (dictchat_Messagesdata.object(forKey: "date") as! String)
            cell.lblAdminTime.text = (dictchat_Messagesdata.object(forKey: "time") as! String)
            cell.txtMessages.text = (dictchat_Messagesdata.object(forKey: "message") as! String)
            cell.imgAdmin.layer.borderWidth = 2.0
            cell.imgAdmin.layer.borderColor = UIColor.red.cgColor

            cell.imgAdmin.sd_setImage(with: URL(string: sChatAdminImageUrl), placeholderImage: UIImage(named: "person"))

            return cell

        }
        
        
    }
    
    func scrollToBottom()
    {
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: self.arrchat_messages.count-1, section: 0)
            self.tblMessageHistory.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    func GetchatHistory()
    {
       
        
       
       
        if let data = UserDefaults.standard.value(forKey: "userData") as? Data{
            let useObj = try? PropertyListDecoder().decode(UserModel.self,from: data)
            accessToken = (useObj?.access_token)!
        }
        hudControllerClass.showNormalHudToViewController(viewController: self)
        weak var weakSelf = self
        WebServiceApi.ChatHistoryApi(accesToken: accessToken, chat_id: chat_id,onSuccess: { [self] (result) in
            
            hudControllerClass.hideHudInViewController(viewController: weakSelf!)
            if let status = result["status"] as? String
            {
                if status == "success"
                {
                    if let dat = result["data"]
                    {
                        
                        dict1Data = result["data"] as! NSDictionary
                        let  iChat_id = dict1Data.object(forKey: "chat_id") as! Int
                        chat_id = String(iChat_id)
                        dictchat_data = dict1Data.object(forKey: "chat_data") as! NSDictionary
                        arrchat_messages = dict1Data.object(forKey: "chat_messages") as! [Any]
                        sChatAdminImageUrl = dictchat_data.object(forKey: "avthar") as! String
                        tblMessageHistory.reloadData()
                        scrollToBottom()
                      
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
    func isValidTextFieldsInputs() -> Bool
    {
           
               var allValidField = true
        if txtInputMessage.text?.isEmpty == true || txtInputMessage.text == nil  || txtInputMessage.text == "0"
        {
            txtInputMessage.becomeFirstResponder()
                   allValidField = false
        }
              
            return allValidField
       }
    
    
    func SaveMessages()
    {
        if isValidTextFieldsInputs()
        {
          
       
        if let data = UserDefaults.standard.value(forKey: "userData") as? Data{
            let useObj = try? PropertyListDecoder().decode(UserModel.self,from: data)
            accessToken = (useObj?.access_token)!
        }
        hudControllerClass.showNormalHudToViewController(viewController: self)
        weak var weakSelf = self
        WebServiceApi.ChatMessageApi(accesToken: accessToken, chat_id: chat_id, chat_msg: txtInputMessage.text!,onSuccess: { [self] (result) in
            
            hudControllerClass.hideHudInViewController(viewController: weakSelf!)
            if let status = result["status"] as? String
            {
                if status == "success"
                {
                    if let dat = result["data"]
                    {
                        txtInputMessage.text = ""
                        self.arrchat_messages.removeAll()
                        self.dict1Data = NSDictionary()
                        self.dictchat_Messagesdata = NSDictionary()
                        self.dictchat_data = NSDictionary()
                        self.GetchatHistory()
                      
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
    
}
