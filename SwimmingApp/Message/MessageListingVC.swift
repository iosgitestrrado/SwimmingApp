//
//  MessageListingVC.swift
//  SwimmingApp
//
//  Created by Monish M S on 26/07/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class MessageListingVC:UIViewController,UISearchControllerDelegate, UISearchBarDelegate{
    
    @IBOutlet var messageListingTableView: UITableView!
    @IBOutlet var header: CommonHeader!
    @IBOutlet weak var txtSearch: UISearchBar!
    @IBOutlet weak var viewBottom: UIView!
    var accessToken = ""
    var chatList = [ChatModel]()
    var filteredData = [ChatModel]()
    var schat_msg = ""
    var sChatName = ""
    var sAvthar = ""
    var sChatdate = ""
    var bSearch = Bool()
    var unread = 0
    var sChildId = ""
    var sSelectedChat_Id = ""

    
    var button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        setupSearchBar()
        messageListingTableView.delegate = self
        messageListingTableView.allowsSelection = true


    }
    func setupSearchBar()
    {
        txtSearch.delegate = self
        filteredData = chatList
        txtSearch.placeholder = "Search"
        txtSearch.returnKeyType = .done
        txtSearch.enablesReturnKeyAutomatically = false
        
    }
    func setupTable(){
        header.backButtonWidth.constant = 0
        header.locationLabel.text = "Messages"
        header.profileNameLabel.text = ""
//        header.imgProfile.sd_setImage(with: URL(string: (UserDefaults.standard.value(forKey: "imgUrl") as! String)), placeholderImage: UIImage(named: "person"))
        header.imgProfile.image = UIImage(named: "")

        messageListingTableView.register(UINib(nibName: "MessageListingVCCell", bundle: nil), forCellReuseIdentifier: "MessageListingVCCell")
        messageListingTableView.rowHeight = UITableView.automaticDimension
        messageListingTableView.allowsSelection = false
        
        button = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true
        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.bottomAnchor.constraint(equalTo: self.messageListingTableView.bottomAnchor, constant: -10).isActive = true
        
        button.addTarget(self, action: #selector(buttonActionForCoachList), for: .touchUpInside)

        let buttonImage = UIImage(named: "add_min") as UIImage?
        button.setImage(buttonImage, for: .normal)

        self.GetChatList()
    }
    @objc func buttonActionForCoachList(sender: UIButton!)
    {
      print("Button tapped")
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let GoVC = storyBoard.instantiateViewController(withIdentifier: "CoachingListViewController") as! CoachingListViewController


        GoVC.child_id  = sChildId

        self.addChild(GoVC)
        GoVC.view.frame = self.view.frame
        self.view.addSubview(GoVC.view)
        GoVC.didMove(toParent: self)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
    {
        txtSearch.resignFirstResponder()
        bSearch = false
        self.view.endEditing(true)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        bSearch = true
        if searchText == ""
        {
            filteredData.removeAll()
            filteredData = chatList
        }
        else
        {
            let filtered  = chatList.filter{ $0.chat_msg!.lowercased().contains(searchText.lowercased()) }
            filteredData = filtered
        }
        
        messageListingTableView.reloadData()

        

    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        searchBar.enablesReturnKeyAutomatically = false
        searchBar.resignFirstResponder()
    }
    func GetChatList()
    {
       
        if let data = UserDefaults.standard.value(forKey: "userData") as? Data{
            let useObj = try? PropertyListDecoder().decode(UserModel.self,from: data)
            accessToken = (useObj?.access_token)!
        }
        hudControllerClass.showNormalHudToViewController(viewController: self)
        weak var weakSelf = self
        WebServiceApi.ChatListApi(accesToken:accessToken,onSuccess: { [self] (result) in
            
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
                                                            
                                                            let locObj = try jsonDecoder.decode(ChatListModel.self, from: datas!)
                                                            self.chatList = locObj.chat_list!

                                                            print("chat list count =\(self.chatList.count)")
                                                            
                                                            messageListingTableView.reloadData()


                                                         }
                                                         catch let parseError
                                                         {
                                                             print("failed LocationModel decoding = \(parseError.localizedDescription)")
                                                         }
                                                     }
                            catch let parseError
                            {
                                print("failed ProfileModel decoding = \(parseError.localizedDescription)")
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
    
    func GetSearchedChatList()
    {
       
        if let data = UserDefaults.standard.value(forKey: "userData") as? Data{
            let useObj = try? PropertyListDecoder().decode(UserModel.self,from: data)
            accessToken = (useObj?.access_token)!
        }
        hudControllerClass.showNormalHudToViewController(viewController: self)
        weak var weakSelf = self
        WebServiceApi.ChatSearchApi(accesToken:accessToken,search: "",onSuccess: { [self] (result) in
            
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
                                                            
                                                            let locObj = try jsonDecoder.decode(ChatListModel.self, from: datas!)
                                                            self.chatList = locObj.chat_list!

                                                            print("chat list count =\(self.chatList.count)")
                                                            messageListingTableView.reloadData()


                                                         }
                                                         catch let parseError
                                                         {
                                                             print("failed LocationModel decoding = \(parseError.localizedDescription)")
                                                         }
                                                     }
                            catch let parseError
                            {
                                print("failed ProfileModel decoding = \(parseError.localizedDescription)")
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
extension MessageListingVC:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if bSearch
        {
            return self.filteredData.count
        }
        else
        {
        return self.chatList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = messageListingTableView.dequeueReusableCell(withIdentifier: "MessageListingVCCell") as! MessageListingVCCell
        if bSearch
        {
            cell.lblCoach.text = self.filteredData[indexPath.row].name
            cell.lblNotification.text = String(self.filteredData[indexPath.row].unread!)
            cell.lblMessage.text = self.filteredData[indexPath.row].chat_msg
            cell.imgMessage.sd_setImage(with: URL(string: self.filteredData[indexPath.row].avthar!), placeholderImage: UIImage(named: "person"))
            cell.lblTime.text = self.filteredData[indexPath.row].date
            
            cell.btnMessage.tag = self.filteredData[indexPath.row].chat_id
            
            let iChat_id = self.filteredData[indexPath.row].chat_id
            
            UserDefaults.standard.setValue(String(iChat_id), forKey: "Chat_id")
            
            cell.btnMessage.addTarget(self,action:#selector(buttonClicked(sender:)), for: .touchUpInside)

            return cell

        }
        else
        {
        cell.lblCoach.text = self.chatList[indexPath.row].name
        cell.lblNotification.text = String(self.chatList[indexPath.row].unread!)
        cell.lblMessage.text = self.chatList[indexPath.row].chat_msg
        cell.imgMessage.sd_setImage(with: URL(string: self.chatList[indexPath.row].avthar!), placeholderImage: UIImage(named: "person"))
            let iChat_id = self.chatList[indexPath.row].chat_id as Int
            
            UserDefaults.standard.setValue(String(iChat_id), forKey: "Chat_id")
            cell.btnMessage.tag = self.chatList[indexPath.row].chat_id
            cell.btnMessage.addTarget(self,action:#selector(buttonClicked(sender:)), for: .touchUpInside)

        cell.lblTime.text = self.chatList[indexPath.row].date
        return cell
        }
    }
   
    @objc func buttonClicked(sender:UIButton)
    {
        let buttonRow = sender.tag
        sSelectedChat_Id = String(buttonRow)

        let storyBoard = UIStoryboard(name: "Message", bundle: nil)
        let popupVC = storyBoard.instantiateViewController(withIdentifier: "MessageHistoryViewController") as! MessageHistoryViewController
        popupVC.chat_id = sSelectedChat_Id

        self.navigationController?.pushViewController(popupVC, animated: true)


        
        print(buttonRow)
//        self.performSegue(withIdentifier: "MessageHistoryViewController", sender: nil)
            
    }
   
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if (segue.identifier == "MessageHistoryViewController")
//        {
//            if let nextViewController = segue.destination as? MessageHistoryViewController
//            {
//                nextViewController.chat_id = sSelectedChat_Id
//            }
//        }
//
//    }
    
}


extension Date
{
    static var currentTimeStamp: Int64{
        return Int64(Date().timeIntervalSince1970 * 1000)
    }
}

