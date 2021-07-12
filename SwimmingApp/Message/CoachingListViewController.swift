//
//  CoachingListViewController.swift
//  SwimmingApp
//
//  Created by MAC on 15/10/20.
//  Copyright © 2020 Monish M S. All rights reserved.
//

import UIKit
import SDWebImage

protocol SelectedProfileDetailsDelegate: class
{
    func sendSelectedProfileDetailsDelegateToViewController(sProfileName: String, sProfileImageName: String, sProfileEmail: String, sProfileMobNumber: String, courseDict: NSDictionary,iSelectedchldId:Int,bSelectedPArent:Bool)
}

class CoachingListViewController: UIViewController
{
   

    @IBOutlet weak var coachListCollectionView: UICollectionView!
    var accessToken = ""
    var child_id = ""
    var bFromProfileDetails = Bool()
    var childDetails = Array<Any>()
    
    var SelectedProfiledelegate: SelectedProfileDetailsDelegate? = nil

    var dictProfile = NSDictionary()
    
    var coachList = [coach_listModel]()
   var sSelectedProfileName = String()
    var sSelectedProfileImgName = String()
    var sSelectedProfileMobNumber = String()
    var sSelectedProfileEmail = String()
    var bIsParent = Bool()
    var iSelectedProfileId = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.GetCoachList()
        // Do any additional setup after loading the view.
        if bFromProfileDetails
        {
//            if let layout = coachListCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
//                layout.scrollDirection = .vertical
//            }
            
            childDetails.append(dictProfile)
        }
    }
    
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    func removeAnimate()
          {
              UIView.animate(withDuration: 0.25, animations: {
                  self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                  self.view.alpha = 0.0;
                  }, completion:{(finished : Bool)  in
                      if (finished)
                      {
                          self.view.removeFromSuperview()
                      }
              });
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         let touch = touches.first
         if touch?.view == self.view
         {
            self.removeAnimate()

        }
    }
    
    func GetCoachList()
    {
        if !bFromProfileDetails
        {
            
        
       
        if let data = UserDefaults.standard.value(forKey: "userData") as? Data{
            let useObj = try? PropertyListDecoder().decode(UserModel.self,from: data)
            accessToken = (useObj?.access_token)!
        }
        hudControllerClass.showNormalHudToViewController(viewController: self)
        weak var weakSelf = self
        WebServiceApi.CoachListApi(accesToken:accessToken, child_id: child_id,onSuccess: { [self] (result) in
            
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
                                                            
                                                            let locObj = try jsonDecoder.decode(coachListModel.self, from: datas!)
                                                            self.coachList = locObj.coach_list!

                                                            print("chat list count =\(self.coachList.count)")
                                                            coachListCollectionView.reloadData()


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
        else
        {
            coachListCollectionView.reloadData()

        }
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
extension CoachingListViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if !bFromProfileDetails
        {
            return self.coachList.count

        }
        else
        {
            return self.childDetails.count

        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
        let coachingCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CoachingListCollectionViewCell", for: indexPath as IndexPath) as! CoachingListCollectionViewCell
        if !bFromProfileDetails
        {
        coachingCell.lblCoach.text = self.coachList[indexPath.row].name
        coachingCell.imgCoach.sd_setImage(with: URL(string: self.coachList[indexPath.row].avthar!), placeholderImage: UIImage(named: "person"))
        }
        else
        {
            let dict3 = childDetails[indexPath.row] as! NSDictionary
            coachingCell.lblCoach.text = (dict3.object(forKey: "name") as! String)
            let imgUrl = (dict3.object(forKey: "avthar") as! String)
            coachingCell.imgCoach.sd_setImage(with: URL(string: imgUrl), placeholderImage: UIImage(named: "person"))

            
        }
        coachingCell.layer.cornerRadius = 5.0

        return coachingCell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        var val = view.bounds.width/2.0
        val = val.rounded()
//        print("Val")
//        print(val)
        return CGSize(width: val, height: val)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        print("taaapppeeedd")
//        self.performSegue(withIdentifier: "sgueToActivityListingDetailVC", sender:nil)
        
//        let coachingCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CoachingListCollectionViewCell", for: indexPath as IndexPath) as! CoachingListCollectionViewCell
        if !bFromProfileDetails
        {
            let storyBoard = UIStoryboard(name: "Message", bundle: nil)
            let popupVC = storyBoard.instantiateViewController(withIdentifier: "MessageHistoryViewController") as! MessageHistoryViewController
            popupVC.chat_id = UserDefaults.standard.value(forKey: "Chat_id") as! String
            self.navigationController?.pushViewController(popupVC, animated: true)
        
        }
        else
        {
            let dict3 = childDetails[indexPath.row] as! NSDictionary
            sSelectedProfileName = (dict3.object(forKey: "name") as! String)
            sSelectedProfileImgName = (dict3.object(forKey: "avthar") as! String)
            sSelectedProfileMobNumber = String(dict3.object(forKey: "phone") as! Int)
            sSelectedProfileEmail = (dict3.object(forKey: "email") as! String)
            self.bIsParent = dict3.object(forKey: "is_parent") as! Bool
            iSelectedProfileId = dict3.object(forKey: "id") as! Int
            var dict5  = NSDictionary()
            
            let null = NSNull()
            if dict3.object(forKey: "course") as Any as! NSNull != null
                {
               
                    if dict3.count != 0
                    {
                        dict5 = dict3.object(forKey: "course") as! NSDictionary

                    }
                }

            

            
            self.SelectedProfiledelegate?.sendSelectedProfileDetailsDelegateToViewController(sProfileName: sSelectedProfileName, sProfileImageName: sSelectedProfileImgName, sProfileEmail: sSelectedProfileEmail, sProfileMobNumber: sSelectedProfileMobNumber, courseDict: dict5,iSelectedchldId:iSelectedProfileId,bSelectedPArent:bIsParent)
            

            removeAnimate()
        }
    }
    

}

