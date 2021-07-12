//
//  ProfileViewController.swift
//  SwimmingApp
//
//  Created by MAC on 09/10/20.
//  Copyright © 2020 Monish M S. All rights reserved.
//

import UIKit
import SDWebImage

class ProfileViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,SelectedProfileDetailsDelegate
{
    
    
    
    
    @IBOutlet weak var tblProfile: UITableView!
    var accessToken = ""
    var sSelectedCourses = 0
    var bIsParent = Bool()

    var sCompletesActivities = 0
    var sRemainingActivities = 0
    var iChildID = 0
    var dictChildrens = Array<Any>()
    var dict1Data = NSDictionary()
    var dictProfile = NSDictionary()

    var bFromProfileSelectionPopUp = Bool()
    var imgProfileUrl = ""
    var sProfilename = ""
    var sPhoneNumber = ""
    var sprofileEmail = ""

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if  bIsParent
        {
            return 7

        }
        else
        {
            return 6
        }
    }
    
    
    
    func sendSelectedProfileDetailsDelegateToViewController(sProfileName: String, sProfileImageName: String, sProfileEmail: String, sProfileMobNumber: String, courseDict: NSDictionary,iSelectedchldId:Int,bSelectedPArent:Bool)
    {
        bFromProfileSelectionPopUp = true
        sProfilename = sProfileName
        imgProfileUrl = sProfileImageName
        self.iChildID = iSelectedchldId
        sPhoneNumber = sProfileMobNumber
        sprofileEmail = sProfileEmail
        self.bIsParent = bSelectedPArent
        if courseDict.count == 0
        {
            self.sSelectedCourses = 0
            self.sCompletesActivities = 0
            self.sRemainingActivities = 0
        }
        else
        {
        self.sSelectedCourses = courseDict.object(forKey: "courses") as! Int
        self.sCompletesActivities = courseDict.object(forKey: "comp_activity") as! Int
        self.sRemainingActivities = courseDict.object(forKey: "pend_activity") as! Int
        }
        tblProfile.reloadData()
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell1  = UITableViewCell()

        if bIsParent
        {
          
        if indexPath.row == 0
        {
          let   cell = tblProfile.dequeueReusableCell(withIdentifier: "Cell1")!as! ProfileDetailsTableViewCell
            if bFromProfileSelectionPopUp
            {
                cell.lblName.text = sProfilename
                cell.imgProfile.sd_setImage(with: URL(string: imgProfileUrl), placeholderImage: UIImage(named: "person"))
                
            }
            else
            {
            cell.lblName.text = sProfilename
            cell.imgProfile.sd_setImage(with: URL(string: imgProfileUrl), placeholderImage: UIImage(named: "person"))
            }
            cell.imgProfile.layer.borderWidth = 4.0
            cell.imgProfile.layer.borderColor = UIColor.black.cgColor

            cell.lblSelectedUsers.text = String(sSelectedCourses)
            cell.lblCompletedActivities.text = String(sCompletesActivities)
            cell.lblRemainingActivities.text = String(sRemainingActivities)

            return cell

        }
        else
        {
         if indexPath.row == 1
        {
             cell1 = tblProfile.dequeueReusableCell(withIdentifier: "Cell2")!
        }
        else if indexPath.row == 2
        {
             cell1 = tblProfile.dequeueReusableCell(withIdentifier: "Cell3")!
        } else if indexPath.row == 3
        {
             cell1 = tblProfile.dequeueReusableCell(withIdentifier: "Cell4")!
        } else if indexPath.row == 4
        {
             cell1 = tblProfile.dequeueReusableCell(withIdentifier: "Cell5")!
        }
        else if indexPath.row == 5
        {
             cell1 = tblProfile.dequeueReusableCell(withIdentifier: "Cell6")!
        }
        else if indexPath.row == 6
        {
             cell1 = tblProfile.dequeueReusableCell(withIdentifier: "Cell7")!
        }
            return cell1

        }
        }
        else
        {
          
        if indexPath.row == 0
        {
          let   cell = tblProfile.dequeueReusableCell(withIdentifier: "Cell1")!as! ProfileDetailsTableViewCell
            if bFromProfileSelectionPopUp
            {
                cell.lblName.text = sProfilename
                cell.imgProfile.sd_setImage(with: URL(string: imgProfileUrl), placeholderImage: UIImage(named: "person"))
                
            }
            else
            {
            cell.lblName.text = sProfilename
            cell.imgProfile.sd_setImage(with: URL(string: imgProfileUrl), placeholderImage: UIImage(named: "person"))
            }
            cell.imgProfile.layer.borderWidth = 4.0
            cell.imgProfile.layer.borderColor = UIColor.black.cgColor

            cell.lblSelectedUsers.text = String(sSelectedCourses)
            cell.lblCompletedActivities.text = String(sCompletesActivities)
            cell.lblRemainingActivities.text = String(sRemainingActivities)

            return cell

        }
        else
        {
         if indexPath.row == 1
        {
             cell1 = tblProfile.dequeueReusableCell(withIdentifier: "Cell2")!
//        }
//        else if indexPath.row == 2
//        {
//             cell1 = tblProfile.dequeueReusableCell(withIdentifier: "Cell3")!
        } else if indexPath.row == 2
        {
             cell1 = tblProfile.dequeueReusableCell(withIdentifier: "Cell4")!
        } else if indexPath.row == 3
        {
             cell1 = tblProfile.dequeueReusableCell(withIdentifier: "Cell5")!
        }
        else if indexPath.row == 4
        {
             cell1 = tblProfile.dequeueReusableCell(withIdentifier: "Cell6")!
        }
        else if indexPath.row == 5
        {
             cell1 = tblProfile.dequeueReusableCell(withIdentifier: "Cell7")!
        }
            return cell1

        }
        }
    }
    
    
    
   
    
    @IBAction func actionChildSelection(_ sender: Any)
    {
        
        print("actionChildSelectionButton tapped")
          let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
          let GoVC = storyBoard.instantiateViewController(withIdentifier: "CoachingListViewController") as! CoachingListViewController

        GoVC.bFromProfileDetails = true
        GoVC.childDetails = self.dictChildrens
        GoVC.dictProfile = self.dictProfile
        GoVC.SelectedProfiledelegate = self

          self.addChild(GoVC)
          GoVC.view.frame = self.view.frame
          self.view.addSubview(GoVC.view)
          GoVC.didMove(toParent: self)
        
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        
        var rowHeight =  349
        if indexPath.row == 0
        {
             rowHeight = 349
        }
        else
        {
             rowHeight = 55
        }
        return CGFloat(rowHeight)
    }
    
      func tableView(_ tableView: UITableView, didSelectRowAt
     indexPath: IndexPath)
      {
        
        print("Tapped")
        
        
        if bIsParent
        {
            
       
        
        
        if indexPath.row == 1
        {
            self.performSegue(withIdentifier: "EditProfileViewController", sender: nil)

        }
        else if indexPath.row == 2
        {
            
            let storyBoard = UIStoryboard(name: "Common", bundle: nil)
            let popupVC = storyBoard.instantiateViewController(withIdentifier: "AddchildViewController") as! AddchildViewController
//            popupVC.sSelectedActivityId = sSelectedActivityId
//            popupVC.pageIndex = pageIndex
//            popupVC.selectedIndex = selectedIndex

            self.addChild(popupVC)
            self.view.addSubview(popupVC.view)
            popupVC.didMove(toParent: self)
//            self.performSegue(withIdentifier: "AddchildViewController", sender: nil)

        }
        
        else if indexPath.row == 3
        {
            
          
            self.performSegue(withIdentifier: "MessageListingVC", sender: nil)

        }
        else if indexPath.row == 4
        {
            self.performSegue(withIdentifier: "AboutUSViewController", sender: nil)

        }
        else if indexPath.row == 5
        {
            self.performSegue(withIdentifier: "TermsAndConditionViewController", sender: nil)

        }
        else if indexPath.row == 6
        {
            // Create the alert controller
                let alertController = UIAlertController(title: "Logout", message: "Are you sure you want to logout", preferredStyle: .alert)

                // Create the actions
           
            let cancelAction = UIAlertAction(title: "No", style: UIAlertAction.Style.cancel) {
                    UIAlertAction in
                    NSLog("Cancel Pressed")
                }
            let okAction = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default) {
                    UIAlertAction in
                    NSLog("OK Pressed")
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = mainStoryboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                UIApplication.shared.keyWindow?.rootViewController = viewController
                }
                // Add the actions
                alertController.addAction(okAction)
                alertController.addAction(cancelAction)

                // Present the controller
                self.present(alertController, animated: true, completion: nil)
        }
        }
        else
        {
            
       
        
        
        if indexPath.row == 1
        {

            self.performSegue(withIdentifier: "EditProfileViewController", sender: nil)


        }
        
        else if indexPath.row == 2
        {
            
          
            self.performSegue(withIdentifier: "MessageListingVC", sender: nil)

        }
        else if indexPath.row == 3
        {
            self.performSegue(withIdentifier: "AboutUSViewController", sender: nil)

        }
        else if indexPath.row == 4
        {
            self.performSegue(withIdentifier: "TermsAndConditionViewController", sender: nil)

        }
        else if indexPath.row == 5
        {
            // Create the alert controller
                let alertController = UIAlertController(title: "Logout", message: "Are you sure you want to logout", preferredStyle: .alert)

                // Create the actions
           
            let cancelAction = UIAlertAction(title: "No", style: UIAlertAction.Style.cancel) {
                    UIAlertAction in
                    NSLog("Cancel Pressed")
                }
            let okAction = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default) {
                    UIAlertAction in
                    NSLog("OK Pressed")
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = mainStoryboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                UIApplication.shared.keyWindow?.rootViewController = viewController
                }
                // Add the actions
                alertController.addAction(okAction)
                alertController.addAction(cancelAction)

                // Present the controller
                self.present(alertController, animated: true, completion: nil)
        }
        }
      }

    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        self.GetProfiledetails()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "MessageListingVC")
        {
            if let nextViewController = segue.destination as? MessageListingVC
            {
                nextViewController.sChildId = String(iChildID)
            }
        }
        else if (segue.identifier == "EditProfileViewController")
        {
            if let nextViewController = segue.destination as? EditProfileViewController
            {
                nextViewController.child_id = String(iChildID)
                nextViewController.sProfileName = sProfilename
                nextViewController.sPhoneNumber = sPhoneNumber
                nextViewController.sEmailId = sprofileEmail
                nextViewController.iSelectdImageUrl = imgProfileUrl


            }
        }
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
                        
                        dict1Data = result["data"] as! NSDictionary
                        
                        self.dictChildrens = dict1Data.object(forKey: "childrens") as! Array<Any>
                        dictProfile = dict1Data.object(forKey: "profile") as!  NSDictionary
                        self.imgProfileUrl = dictProfile.object(forKey: "avthar") as! String
                        self.sProfilename = dictProfile.object(forKey: "name") as! String
                        self.sprofileEmail = dictProfile.object(forKey: "name") as! String
                        self.sPhoneNumber = dictProfile.object(forKey: "email") as! String

                        self.bIsParent = dictProfile.object(forKey: "is_parent") as! Bool
                        
                        if dictChildrens.count > 0
                        {
                            let dict3 = dictChildrens[0] as! NSDictionary
                            let child_id = dict3.object(forKey: "id") as! Int
                            self.iChildID = child_id
                            let dict5 = dict3.object(forKey: "course") as! NSDictionary
                            self.sSelectedCourses = dict5.object(forKey: "courses") as! Int
                            self.sCompletesActivities = dict5.object(forKey: "comp_activity") as! Int
                            self.sRemainingActivities = dict5.object(forKey: "pend_activity") as! Int
                            
                        }
                        
                        
                        tblProfile.reloadData()


                        
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
