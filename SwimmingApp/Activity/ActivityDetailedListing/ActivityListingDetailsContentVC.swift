//
//  ActivityListingDetailsContentVC.swift
//  SwimmingApp
//
//  Created by Monish M S on 20/09/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class ActivityListingDetailsContentVC:UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    
    @IBOutlet var activityListingTableView: UITableView!
   
    
    var pageIndex: Int = 0
    var sSelectedActivityId = ""
    var accessToken = ""
    var sActivityName = ""
    var sActivityDescription = ""
    var bSubmittedActivities = Bool()

    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        print("ActivityListingDetailsContentVC")
    }
    
    func setupUI()
    {
    
        self.GetSelectedActivityListDetails()
        
        
        // for Submitted Actiovities
        
        if bSubmittedActivities
        {
            activityListingTableView.register(UINib(nibName: "ActivityDetailsTopViewCell", bundle: nil), forCellReuseIdentifier: "ActivityDetailsTopViewCell")

            activityListingTableView.register(UINib(nibName: "ActivityDetailsBadgeTableViewCell", bundle: nil), forCellReuseIdentifier: "ActivityDetailsBadgeTableViewCell")

        }
        else
        {
            activityListingTableView.register(UINib(nibName: "NextActivityDetailedVCCell", bundle: nil), forCellReuseIdentifier: "NextActivityDetailedVCCell")

        }

        
        activityListingTableView.rowHeight = UITableView.automaticDimension
    }
}

extension ActivityListingDetailsContentVC:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
//        if section == 0{
//            return 1
//        }
        if bSubmittedActivities
        {
            return 2
        }
        else
        {
            return 1

        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        if indexPath.section == 0{
        
        if !bSubmittedActivities
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NextActivityDetailedVCCell", for: indexPath) as! NextActivityDetailedVCCell
        
        cell.remarksTextView.layer.cornerRadius = 10
        cell.remarksTextView.layer.borderWidth = 1.5
        cell.remarksTextView.layer.borderColor = UIColor.lightGray.cgColor
        cell.lblActivityName.text = sActivityName
        cell.txtActivityDescription.text = sActivityDescription
        cell.btnSubmit.addTarget(self, action: #selector(buttonActionForSumbitActivity), for: .touchUpInside)
        cell.btnUploadVideoOrImage.addTarget(self, action: #selector(buttonActionForUploadImageOrViedeo), for: .touchUpInside)

            return cell
        }
           else
        {
            if indexPath.row == 0
            {
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "ActivityDetailsTopViewCell", for: indexPath) as! ActivityDetailsTopViewCell
                
                cell1.btRepeat.addTarget(self, action: #selector(buttonActionForRepeatActivity), for: .touchUpInside)
                return cell1
            }
            else
            {
                let cell2 = tableView.dequeueReusableCell(withIdentifier: "ActivityDetailsBadgeTableViewCell", for: indexPath) as! ActivityDetailsBadgeTableViewCell
                cell2.btnShare.addTarget(self, action: #selector(buttonActionForShareActivity), for: .touchUpInside)
                    return cell2
            }

        }
//        }else{
//            let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityDetailsBottomTableViewCell", for: indexPath) as! ActivityDetailsBottomTableViewCell
//           // cell.acivityListingCollectionViewHeight.constant = (UIScreen.main.bounds.width/3.5)
//            cell.frame = tableView.bounds
//            cell.layoutIfNeeded()
//            cell.acivityListingCollectionViewHeight.constant = cell.activityListingCollectionView.collectionViewLayout.collectionViewContentSize.height
//            return cell
//        }
        
    }
    
    @objc func buttonActionForShareActivity(sender: UIButton!)
    {
      print("buttonActionForShareActivity tapped")

        
    }
    
    
    @objc func buttonActionForRepeatActivity(sender: UIButton!)
    {
      print("buttonActionForRepeatActivity tapped")

        
    }
    
    @objc func buttonActionForSumbitActivity(sender: UIButton!)
    {
      print("buttonActionForSumbitActivity tapped")
        self.SaveSelectedActiivitydetails()
       
    }
    @objc func buttonActionForUploadImageOrViedeo(sender: UIButton!)
    {
        
        let alert = UIAlertController(title: "Choose Image or Viedeo", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallery()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        //If you want work actionsheet on ipad then you have to use popoverPresentationController to present the actionsheet, otherwise app will crash in iPad
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            alert.popoverPresentationController?.sourceView = (sender as! UIView)
            alert.popoverPresentationController?.sourceRect = (sender as AnyObject).bounds
            alert.popoverPresentationController?.permittedArrowDirections = .up
        default:
            break
        }

        self.present(alert, animated: true, completion: nil)
    }
    
    
    func openCamera()
     {

            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera)
            {
             imagePicker.sourceType = UIImagePickerController.SourceType.camera
                //If you dont want to edit the photo then you can set allowsEditing to false
                imagePicker.allowsEditing = true
                imagePicker.delegate = self
                self.present(imagePicker, animated: true, completion: nil)
            }
        
     }
    
    func openGallery()
    {
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        //If you dont want to edit the photo then you can set allowsEditing to false
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    
    func saveImageToDocumentDirectorys(image: UIImage,fileName:String )
       {
           let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
           let fileName = fileName // name of the image to be saved
           let fileURL = documentsDirectory.appendingPathComponent(fileName)
           if let data = image.jpegData(compressionQuality: 1.0),!FileManager.default.fileExists(atPath: fileURL.path){
               do {
                   try data.write(to: fileURL)
                   print("file saved saveImageToDocumentDirectorys")
               } catch {
                   print("error saving file:", error)
               }
           }
       }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        
                let index = IndexPath(row: 0, section: 0)
                let cell: NextActivityDetailedVCCell = self.activityListingTableView.cellForRow(at: index) as! NextActivityDetailedVCCell
        
        if let pickedImage = info[.originalImage] as? UIImage
      {
        self.saveImageToDocumentDirectory(image: pickedImage)
            cell.imgUploadedViedeo_Image.image = pickedImage

        let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let nsUserDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
        let imageURL = URL(fileURLWithPath: paths.first!).appendingPathComponent("avthar.png")
            cell.imgUploadedViedeo_Image.image = info[.originalImage] as? UIImage
            cell.imgUploadedViedeo_Image.layer.cornerRadius = 50.0
           
      picker.dismiss(animated: true, completion: nil)
    }
    }
    
    func saveImageToDocumentDirectory(image: UIImage )
    {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileName = "avthar.png" // name of the image to be saved
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        if let data = image.jpegData(compressionQuality: 1.0),!FileManager.default.fileExists(atPath: fileURL.path){
            do {
                try data.write(to: fileURL)
                print("file saved")
            } catch {
                print("error saving file:", error)
            }
        }
    }


    func loadImageFromDocumentDirectory(nameOfImage : String) -> UIImage
    {
        let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let nsUserDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
        if let dirPath = paths.first
        {
            let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent(nameOfImage)
            let image    = UIImage(contentsOfFile: imageURL.path)
            return image!
        }
        return UIImage.init(named: "default.png")!
    }
    
    
    func SaveSelectedActiivitydetails()
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
        
        let index = IndexPath(row: 0, section: 0)
        let cell: NextActivityDetailedVCCell = self.activityListingTableView.cellForRow(at: index) as! NextActivityDetailedVCCell

        
        WebServiceApi.SubmitActivityApi(accesToken: accessToken, activity_id: sSelectedActivityId as! String, child_id: sChildId as! String,description: cell.remarksTextView.text ,onSuccess: { [self] (result) in
            
            hudControllerClass.hideHudInViewController(viewController: weakSelf!)
            if let status = result["status"] as? String
            {
                if status == "success"
                {
                    if let dat = result["data"]
                    {
                        self.showPopUp(message:"Successfully Saved")
                        self.navigationController?.popViewController(animated: true)
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
    
    
    func SaveCapyuredImagesAndViedeos()
    {
        
        let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let nsUserDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
        let imageURL = URL(fileURLWithPath: paths.first!).appendingPathComponent("avthar.png")
        
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
        let index = IndexPath(row: 0, section: 0)
        let cell: NextActivityDetailedVCCell = self.activityListingTableView.cellForRow(at: index) as! NextActivityDetailedVCCell
        
        let thumb1 = cell.imgUploadedViedeo_Image.image!.resized(withPercentage: 0.1)
        var imgData = thumb1!.pngData()
        let imgName = imageURL.lastPathComponent
        print(imageURL.lastPathComponent) // get file Name
        print(imageURL.pathExtension)   // get file extension
        print("imageName:\(imgName)")
        
       
        let parameters = ["accesToken" : accessToken,"activity_id" : sArryCourseId[pageIndex],"child_id" :  sChildId] as [String : Any]
        


        let url = webServiceUrls.submitActivityMediaUrl

        Alamofire.upload(multipartFormData: { (multipartFormData) in
          for (key, value) in parameters {
            multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
          }
          if let data = imgData
          {
           multipartFormData.append(imgData!, withName: "media", fileName: imgName , mimeType: "image/video")
          }
        }, usingThreshold: UInt64.init(), to: url, method: .post ,headers: nil ) { (result) in
          switch result{
          case .success(let upload, _, _):
            upload.responseJSON { response in
         let statValue = response.response?.statusCode
         if statValue == 200
           {
            hudControllerClass.hideHudInViewController(viewController: weakSelf!)
            self.showPopUp(message: "ActivityDetails are  Submitted successfully")
            self.navigationController?.popViewController(animated: true)

             }
             else if statValue == 401
             {

                hudControllerClass.hideHudInViewController(viewController: weakSelf!)

                 
             }
             else
             {

                hudControllerClass.hideHudInViewController(viewController: weakSelf!)

             }
              if let err = response.error
              {
                print(err)
                return
              }
            }
          case .failure(let error):
            print("Error in upload: \(error.localizedDescription)")
          }
        }
        hudControllerClass.hideHudInViewController(viewController: weakSelf!)

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
                                                            
                                                            sActivityName = (locObj.detail?.activity_name)!
                                                            sActivityDescription = (locObj.detail?.activity_desc)!
                                                            activityListingTableView.reloadData()

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
                            print("failed Activity_DetailModel  JSON Serialiation")
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
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 600
    }
    
    
}
