//
//  HomeDashBoardVC.swift
//  SwimmingApp
//
//  Created by Monish M S on 28/09/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

import Foundation
import UIKit
import ABSteppedProgressBar
class HomeDashBoardVC:UIViewController{
    
    @IBOutlet var activitiesCollectionView: UICollectionView!
    @IBOutlet var progressBar: ABSteppedProgressBar!
    @IBOutlet var badgeCollectionView: UICollectionView!
    @IBOutlet var milestoneView: UIView!
    
    var accessToken = ""
    var sSelectedActivityId = ""
    var sSelectedCourses = 0
    var upcomingActivitiesList = [upcomingModel]()
    var inprogressActivitiesList = [inprogressModel]()
    var completeActivitiesList = [completeModel]()
    var rejectedActivitiesList = [rejectedModel]()
    var sActivityNameArray = [String]()
    var sUpcomingActivityImageArray = [String]()
    var sInprogressActivityImageArray = [String]()
    var sCompleatedActivityImageArray = [String]()
    var sRejectedActivityImageArray = [String]()

    var sActivityStatusArray = [String]()
    var mediaModelsList = [mediaModels]()
    var mediaModelsList2 = mediaModels()
    var allActivityId = [String]()
    
    var activityListArray = ["A1","A2","A3","A4","A5","A6"]
    var menuItemTapped = [Int:Bool]()
    let color = UIColor(red: 53.0/255.0, green: 152.0/255.0, blue: 219.0/255.0, alpha: 1.0)
    var pageIndex: Int = 0
    var selectedIndex:Int = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI(){
        self.GetAllActivityListForSelectedCourses()
        self.navigationController?.navigationBar.isHidden = true
        milestoneView.layer.cornerRadius = 15.0
        milestoneView.isUserInteractionEnabled = false
        activitiesCollectionView.delegate = self
        badgeCollectionView.delegate = self
        progressBar.currentIndex = 0
    }
    
    @objc func backButtonTapped(_ button:UIButton){
        self.navigationController?.popViewController(animated: false)
    }
    
    
    @IBAction func ActionExplore(_ sender: Any)
    {
        print("tap[pppped")
        self.performSegue(withIdentifier: "ShowExplore", sender:nil)

    }
    
}





extension HomeDashBoardVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if collectionView == activitiesCollectionView
        {
            return self.upcomingActivitiesList.count

        }
        else
        {
            return self.inprogressActivitiesList.count

        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
        
        var activityCell = HomeUpComingActivityListCollectionViewCell()
        
        var badgeCell = BadgeCollectionViewCell()
        
        if collectionView == activitiesCollectionView
        {
            activityCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeUpComingActivityListCollectionViewCell", for: indexPath as IndexPath) as! HomeUpComingActivityListCollectionViewCell
            activityCell.lblUpcomingActivities.text = self.upcomingActivitiesList[indexPath.row].activity_name
            if (self.upcomingActivitiesList[indexPath.row].media.count > 0)
            {
                activityCell.imgUpcominActivities.sd_setImage(with: URL(string: (self.upcomingActivitiesList[indexPath.row].media[0].file!)), placeholderImage: UIImage(named: "person"))

            }
            else
            {
//                activityCell.imgUpcominActivities.sd_setImage(with: URL(string: ""), placeholderImage: UIImage(named: "swimm"))
            }
            activityCell.layer.cornerRadius = 15.0
            return activityCell
        }
        else
        {
            badgeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "BadgeCollectionViewCell", for: indexPath as IndexPath) as! BadgeCollectionViewCell
            
            badgeCell.layer.cornerRadius = 15.0
            badgeCell.lblPastActivitiesName.text = self.inprogressActivitiesList[indexPath.row].activity_name
            if (self.inprogressActivitiesList[indexPath.row].media.count > 0)
            {
                badgeCell.badgeImageView.sd_setImage(with: URL(string: (self.inprogressActivitiesList[indexPath.row].media[0].file!)), placeholderImage: UIImage(named: "person"))
                if (self.inprogressActivitiesList[indexPath.row].media.count > 1)
                {
                    badgeCell.imgPastActivities2.sd_setImage(with: URL(string: (self.inprogressActivitiesList[indexPath.row].media[1].file!)), placeholderImage: UIImage(named: "person"))

                }
                

            }
            else
            {
//                activityCell.imgUpcominActivities.sd_setImage(with: URL(string: ""), placeholderImage: UIImage(named: "swimm"))
            }
            
            if self.inprogressActivitiesList[indexPath.row].curr_status == 2
            {
                badgeCell.badgeTopView.layer.backgroundColor = UIColor.orange.cgColor
                progressBar.currentIndex = 1


            }
            else
            {
                badgeCell.badgeTopView.layer.backgroundColor = UIColor.green.cgColor
                progressBar.currentIndex = 2

               
            }
            
            
            

            
            return badgeCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == badgeCollectionView
        {
            let yourWidth = (collectionView.bounds.width/3)
            let yourHeight = yourWidth
            return CGSize(width: yourWidth, height: 120)
        }
        return CGSize(width: 100, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        
        
        
        if collectionView == activitiesCollectionView
        {
            sSelectedActivityId = String(self.upcomingActivitiesList[indexPath.row].id!)
            print("taaapppeeedd Activity Id :" ,sSelectedActivityId)
            print("taaapppeeedd")
            let storyBoard = UIStoryboard(name: "Common", bundle: nil)
            let popupVC = storyBoard.instantiateViewController(withIdentifier: "CourseDetailsPopUpViewController") as! CourseDetailsPopUpViewController
            popupVC.sSelectedActivityId = sSelectedActivityId
            popupVC.pageIndex = pageIndex
            popupVC.selectedIndex = selectedIndex

            self.addChild(popupVC)
            self.view.addSubview(popupVC.view)
            popupVC.didMove(toParent: self)

        }
        
        
    }
    
    func maskRoundedImage(image: UIImage, radius: CGFloat) -> UIImage {
        let imageView: UIImageView = UIImageView(image: image)
        let layer = imageView.layer
        layer.masksToBounds = true
        layer.cornerRadius = radius
        UIGraphicsBeginImageContext(imageView.bounds.size)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let roundedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return roundedImage!
    }
    func GetAllActivityListForSelectedCourses()
    {
       
        if let data = UserDefaults.standard.value(forKey: "userData") as? Data
        {
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
                                                                        self.sUpcomingActivityImageArray.append(Upcomingactivity.media[0].file!)

                                                                    }
                                                                    else
                                                                    {
                                                                        self.sUpcomingActivityImageArray.append("")
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
                                                                        self.sInprogressActivityImageArray.append(Upcomingactivity.media[0].file!)

                                                                    }
                                                                    else
                                                                    {
                                                                        self.sInprogressActivityImageArray.append("")
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
                                                                        self.sRejectedActivityImageArray.append(Upcomingactivity.media[0].file!)

                                                                    }
                                                                    else
                                                                    {
                                                                        self.sRejectedActivityImageArray.append("")
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
                                                                        self.sCompleatedActivityImageArray.append(Upcomingactivity.media[0].file!)

                                                                    }
                                                                    else
                                                                    {
                                                                        self.sCompleatedActivityImageArray.append("")
                                                                    }

//                                                                    self.mediaModelsList.append(contentsOf: Upcomingactivity.media)
                                                                    }
                                                            }
                                                            print(self.upcomingActivitiesList.count)
                                                            activitiesCollectionView.reloadData()
                                                            badgeCollectionView.reloadData()

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

