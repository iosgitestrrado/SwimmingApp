//
//  ActivityListingContentVC.swift
//  SwimmingApp
//
//  Created by Monish M S on 19/09/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage
class ActivityListingContentVC:UIViewController{
    
    @IBOutlet var activityListCollectionView: UICollectionView!
    
    @IBOutlet weak var viewMoActivityCourses: UIView!
    var pageIndex: Int = 0
    var selectedIndex:Int = 0
    var accessToken = ""
    var sSelectedActivityId = ""
    var bSubmittedActivities = Bool()

    var sSelectedCourses = 0
    var upcomingActivitiesList = [upcomingModel]()
    var inprogressActivitiesList = [inprogressModel]()
    var completeActivitiesList = [completeModel]()
    var rejectedActivitiesList = [rejectedModel]()
    var sActivityNameArray = [String]()
    var sActivityImageArray = [String]()
    var sActivityStatusArray = [String]()
    var mediaModelsList = [mediaModels]()
    var mediaModelsList2 = mediaModels()
    var allActivityId = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    @IBAction func ActionExplore(_ sender: Any)
    {
        print("tap[pppped")
        self.performSegue(withIdentifier: "ShowExplore", sender:nil)

    }
    
    
    func setupUI()
    {
        
        
        let sArryCourseId = UserDefaults.standard.value(forKey: "Course_Primary_Id") as! [Int]
        print(sArryCourseId[0])
        self.sActivityImageArray.removeAll()
        self.sActivityStatusArray.removeAll()
        self.sActivityNameArray.removeAll()
        GetAllActivityListForSelectedCourses()
        activityListCollectionView.register(ActivityListFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "ActivityListFooterView")
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if (segue.identifier == "sgueToActivityListingDetailVC")
        {
            if let nextViewController = segue.destination as? ActivityListingDetailsVC
            {
                nextViewController.selectedIndex = pageIndex
                nextViewController.sSelectedActivityId = sSelectedActivityId
                nextViewController.bSubmittedActivities = bSubmittedActivities
                
            }
        }
    }
    
    
    func GetAllActivityListForSelectedCourses()
    {
       
        if let data = UserDefaults.standard.value(forKey: "userData") as? Data{
            let useObj = try? PropertyListDecoder().decode(UserModel.self,from: data)
            accessToken = (useObj?.access_token)!
        }
        var sChildId = "0"
        sChildId = UserDefaults.standard.value(forKey: "Child_id") as! String
        
        let sArryCourseId = UserDefaults.standard.value(forKey: "Course_Primary_Id") as! [Int]
        print(sArryCourseId[selectedIndex])
        
        hudControllerClass.showNormalHudToViewController(viewController: self)
        weak var weakSelf = self
        
        
        WebServiceApi.MyActivitiesApi(accesToken: accessToken, child_id: sChildId as! String, course_id: String(sArryCourseId[selectedIndex]),onSuccess: { [self] (result) in
            
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
                                                            
                                                            let locObj = try jsonDecoder.decode(activity_listModel.self, from: datas!)
                                                            print(locObj.activities as Any)
                                                            self.upcomingActivitiesList = locObj.activities!.upcoming
                                                            self.inprogressActivitiesList = locObj.activities!.inprogress
                                                            self.rejectedActivitiesList = locObj.activities!.rejected
                                                            self.completeActivitiesList = locObj.activities!.complete
                                                            
                                                            if self.upcomingActivitiesList.count > 0
                                                            {
                                                                for Upcomingactivity in self.upcomingActivitiesList
                                                                    {
                                                                    
                                                                    self.sActivityNameArray.append(Upcomingactivity.activity_name!)
                                                                    self.sActivityStatusArray.append(String(Upcomingactivity.curr_status!))
                                                                    self.allActivityId.append(String(Upcomingactivity.id!))
                                                                    
                                                                    self.mediaModelsList.append(contentsOf: Upcomingactivity.media)
                                                                    if Upcomingactivity.media.count>0
                                                                    {
                                                                        self.sActivityImageArray.append(Upcomingactivity.media[0].file!)

                                                                    }
                                                                    else
                                                                    {
                                                                        self.sActivityImageArray.append("")
                                                                    }

                                                                    }
                                                            }
                                                            if self.inprogressActivitiesList.count > 0
                                                            {
                                                                for Upcomingactivity in self.inprogressActivitiesList
                                                                    {
                                                                    
                                                                    self.sActivityNameArray.append(Upcomingactivity.activity_name!)
                                                                    self.sActivityStatusArray.append(String(Upcomingactivity.curr_status!))
                                                                    self.mediaModelsList = Upcomingactivity.media
                                                                    self.allActivityId.append(String(Upcomingactivity.id!))

                                                                    
                                                                    if Upcomingactivity.media.count>0
                                                                    {
                                                                        self.sActivityImageArray.append(Upcomingactivity.media[0].file!)

                                                                    }
                                                                    else
                                                                    {
                                                                        self.sActivityImageArray.append("")
                                                                    }

//                                                                    self.mediaModelsList.append(contentsOf: Upcomingactivity.media)

                                                                    }
                                                            }
                                                            if self.rejectedActivitiesList.count > 0
                                                            {
                                                                for Upcomingactivity in self.rejectedActivitiesList
                                                                    {
                                                                    
                                                                    self.sActivityNameArray.append(Upcomingactivity.activity_name!)
                                                                    self.sActivityStatusArray.append(String(Upcomingactivity.curr_status!))
                                                                    self.allActivityId.append(String(Upcomingactivity.id!))

                                                                    self.mediaModelsList = Upcomingactivity.media
                                                                    
                                                                    if Upcomingactivity.media.count>0
                                                                    {
                                                                        self.sActivityImageArray.append(Upcomingactivity.media[0].file!)

                                                                    }
                                                                    else
                                                                    {
                                                                        self.sActivityImageArray.append("")
                                                                    }

//                                                                    self.mediaModelsList.append(contentsOf: Upcomingactivity.media)
                                                                    
                                                                    
                                                                    }
                                                            }
                                                            if self.completeActivitiesList.count > 0
                                                            {
                                                                for Upcomingactivity in self.completeActivitiesList
                                                                    {
                                                                    
                                                                    self.sActivityNameArray.append(Upcomingactivity.activity_name!)
                                                                    self.sActivityStatusArray.append(String(Upcomingactivity.curr_status!))
                                                                    
                                                                    self.allActivityId.append(String(Upcomingactivity.id!))

                                                                    if Upcomingactivity.media.count>0
                                                                    {
                                                                        self.sActivityImageArray.append(Upcomingactivity.media[0].file!)

                                                                    }
                                                                    else
                                                                    {
                                                                        self.sActivityImageArray.append("")
                                                                    }

//                                                                    self.mediaModelsList.append(contentsOf: Upcomingactivity.media)
                                                                    }
                                                            }
                                                            print(self.upcomingActivitiesList.count)
                                                            activityListCollectionView.reloadData()

                                                         }
                                                         catch let parseError
                                                         {
                                                             print("failed activity_listModel decoding = \(parseError.localizedDescription)")
                                                         }
                                                     }
                            catch let parseError
                            {
                                print("failed activity_listModel decoding = \(parseError.localizedDescription)")
                            }
                        }
                        catch {
                            print("failed activity_listModel Model JSON Serialiation")
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

extension ActivityListingContentVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.sActivityNameArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let activityCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActivityListingTempVCCell", for: indexPath as IndexPath) as! ActivityListingTempVCCell


        activityCell.topView.clipsToBounds = true
        activityCell.activityName.text = self.sActivityNameArray[indexPath.row]
//        activityCell.activityName.text = self.upcomingActivitiesList[indexPath.row].activity_name
        if self.sActivityStatusArray[indexPath.row] == "0"
        {
            activityCell.topView.backgroundColor = UIColor.gray
        }
        else if self.self.sActivityStatusArray[indexPath.row] == "2"
        {
            activityCell.topView.backgroundColor = UIColor.orange

        }
        else if self.self.sActivityStatusArray[indexPath.row] == "3"
        {
            activityCell.topView.backgroundColor = UIColor.green

        }
        activityCell.activityImage.layer.cornerRadius = activityCell.activityImage.bounds.height / 2
        
        activityCell.topView.layer.cornerRadius = min( activityCell.topView.frame.size.height,  activityCell.topView.frame.size.width) / 2.0

        
//        activityCell.topView.layer.cornerRadius = activityCell.topView.bounds.height / 2
        let imgUrl = self.sActivityImageArray[indexPath.row]
        activityCell.activityImage.sd_setImage(with: URL(string: imgUrl), placeholderImage: UIImage(named: "swim"))

        return activityCell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        var val = view.bounds.width/2.0
        val = val.rounded()
//        print("Val")
//        print(val)
        return CGSize(width: val - 7, height: val + 10)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        if self.sActivityStatusArray[indexPath.row] == "2"
        {
            print("In Progress")
            bSubmittedActivities = false
        }
        else
        {
            if  self.sActivityStatusArray[indexPath.row] == "3"
            {
                bSubmittedActivities = true

            }
            else
            {
                bSubmittedActivities = false

            }
            
        sSelectedActivityId = self.allActivityId[indexPath.row]
        
        print("taaapppeeedd id ",sSelectedActivityId)

        self.performSegue(withIdentifier: "sgueToActivityListingDetailVC", sender:nil)
        
        }
    }
    
    
}

