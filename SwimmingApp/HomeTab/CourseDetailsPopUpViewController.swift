//
//  CourseDetailsPopUpViewController.swift
//  SwimmingApp
//
//  Created by MAC on 09/10/20.
//  Copyright © 2020 Monish M S. All rights reserved.
//

import UIKit

class CourseDetailsPopUpViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    
    var sSelectedActivityId = ""
    var accessToken = ""
    var pageIndex: Int = 0
    var selectedIndex:Int = 0
    var sActivityImageArray = [String]()
    
    
   
    @IBOutlet weak var viewBase: UIView!
    
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var imgCollectionView: UICollectionView!
    @IBOutlet weak var txtViewdescription: UITextView!
    @IBOutlet weak var lblActivity: UILabel!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        viewBase.layer.cornerRadius = 10.0
        self.GetSelectedActivityListDetails()
        // Do any additional setup after loading the view.
    }


    @IBAction func ActionCancel(_ sender: Any)
    {
        self.view.removeFromSuperview()

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return  sActivityImageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        var coursepopuPCCell = HomeDertailsCollectionViewCell()
        coursepopuPCCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeDertailsCollectionViewCell", for: indexPath as IndexPath) as! HomeDertailsCollectionViewCell
        coursepopuPCCell.cellImage.sd_setImage(with: URL(string: (sActivityImageArray[indexPath.row])), placeholderImage: UIImage(named: "person"))
        coursepopuPCCell.cellImage.layer.cornerRadius = 10.0
        coursepopuPCCell.layer.cornerRadius = 10.0
        return coursepopuPCCell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
     
//            let yourWidth = (collectionView.bounds.width/3)
//            let yourHeight = yourWidth
            return CGSize(width: 150, height: 120)
       
    }
    func GetSelectedActivityListDetails()
    {
       
        if let data = UserDefaults.standard.value(forKey: "userData") as? Data{
            let useObj = try? PropertyListDecoder().decode(UserModel.self,from: data)
            accessToken = (useObj?.access_token)!
        }
        
        var sChildId = "0"
        sChildId = UserDefaults.standard.value(forKey: "Child_id") as! String
        let sArryCourseId = UserDefaults.standard.value(forKey: "Course_Primary_Id") as! [Int]
        print(sArryCourseId[pageIndex])
        
        
        hudControllerClass.showNormalHudToViewController(viewController: self)
        weak var weakSelf = self
        WebServiceApi.ActivityDetailApi(accesToken: accessToken, child_id: sChildId as! String, activity_id: sSelectedActivityId,onSuccess: { [self] (result) in
            
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
                                                            
                                                            let locObj = try jsonDecoder.decode(Activity_DetailModel.self, from: datas!)

                                                            print(locObj.detail?.activity_name)
                                                            
                                                            lblActivity.text = (locObj.detail?.activity_name)!
                                                            txtViewdescription.text = (locObj.detail?.activity_desc)!
                                                            
                                                            if (locObj.detail?.media.count)! > 0
                                                            {
                                                                
                                                                sActivityImageArray.append((locObj.detail?.media[0].file)!)
                                                            }
                                                            
                                                            
                                                            imgCollectionView.reloadData()
                                                            

                                                         }
                                                         catch let parseError
                                                         {
                                                             print("failed Activity_DetailModel decoding = \(parseError.localizedDescription)")
                                                         }
                                                     }
                            catch let parseError
                            {
                                print("failed Activity_DetailModel decoding = \(parseError.localizedDescription)")
                            }
                        }
                        catch {
                            print("failed Activity_DetailModel JSON Serialiation")
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
