//
//  ChildPopUpViewController.swift
//  SwimmingApp
//
//  Created by MAC on 22/10/20.
//  Copyright © 2020 Monish M S. All rights reserved.
//

import UIKit
import SDWebImage



protocol SelectedChildDetailsDelegate: class
{
    func sendSelectedChildDFetailsD(sProfileName: String, sProfileImageName: String, sProfileEmail: String, sProfileMobNumber: String,iSelectedchldId:Int)
}

class ChildPopUpViewController: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource{

    @IBOutlet weak var childPopUpCollectionView: UICollectionView!
    var accessToken = ""
    var child_id = ""
    var SelectedChildDetailsDelegate: SelectedChildDetailsDelegate? = nil

    var bFromProfileDetails = Bool()
    var childDetails = Array<Any>()
    var sSelectedProfileName = String()
     var sSelectedProfileImgName = String()
     var sSelectedProfileMobNumber = String()
     var sSelectedProfileEmail = String()
    var iChildID = 0
    var dictChildrens = Array<Any>()
    var dict1Data = NSDictionary()
    var dictProfile = NSDictionary()
     var iSelectedProfileId = Int()
    var imgProfileUrl = ""
    var sProfilename = ""
    var sTopBarCourseArray = [String] ()
    var sTopBarcourse_codeArray = [String] ()

    var topBarCourseIds = [Int]()
    var topBarCourse_course_ids = [Int]()
    var course_listModelData : [courseModelData]?
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        GetProfiledetails()
    }
    
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

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
       
        let coachingCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChildPopUpCollectionViewCell", for: indexPath as IndexPath) as! ChildPopUpCollectionViewCell
        
        let iIndexPath = indexPath.row as Int
        
        let dict3 = dictChildrens[iIndexPath] as! NSDictionary
        
        coachingCell.lblActivityName.text = (dict3.object(forKey: "name") as! String)
        
        coachingCell.imgChildPopUp.sd_setImage(with: URL(string: dict3.object(forKey: "avthar") as! String ), placeholderImage: UIImage(named: "person"))

        coachingCell.layer.cornerRadius = 5.0

        return coachingCell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        
        return dictChildrens.count

        
    }
    
   
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        var val = collectionView.bounds.width/2.0
        val = val.rounded()
//        print("Val")
//        print(val)
        return CGSize(width: val, height: val)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        print("taaapppeeedd")
        let iIndexPath = indexPath.row as Int
        
        let dict3 = dictChildrens[iIndexPath] as! NSDictionary
        
        sSelectedProfileName = (dict3.object(forKey: "name") as! String)
        sSelectedProfileImgName = dict3.object(forKey: "avthar") as! String
        sSelectedProfileEmail = dict3.object(forKey: "email") as! String
        sSelectedProfileMobNumber = String(dict3.object(forKey: "phone") as! Int)

        UserDefaults.standard.setValue(sSelectedProfileImgName, forKey: "imgUrl")
        
        iChildID = dict3.object(forKey: "id") as! Int

        UserDefaults.standard.setValue(String(iChildID), forKey: "Child_id")
        self.GetCourseListData()
        
        self.SelectedChildDetailsDelegate?.sendSelectedChildDFetailsD(sProfileName: sSelectedProfileName, sProfileImageName: sSelectedProfileImgName , sProfileEmail: sSelectedProfileEmail, sProfileMobNumber: sSelectedProfileMobNumber, iSelectedchldId: iChildID)
        
        self.removeAnimate()
        
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


        WebServiceApi.MyCoursesApi(accesToken: accessToken, child_id: sChildId ,onSuccess: { [self] (result) in
            
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
                        
                        if dictChildrens.count > 0
                        {
                            let dict3 = dictChildrens[0] as! NSDictionary
                            let child_id = dict3.object(forKey: "id") as! Int
                            self.iChildID = child_id
//                            let dict5 = dict3.object(forKey: "course") as! NSDictionary
//                            self.sSelectedCourses = dict5.object(forKey: "courses") as! Int
//                            self.sCompletesActivities = dict5.object(forKey: "comp_activity") as! Int
//                            self.sRemainingActivities = dict5.object(forKey: "pend_activity") as! Int
                            
                        }
                        
                        childPopUpCollectionView.reloadData()
                        

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




