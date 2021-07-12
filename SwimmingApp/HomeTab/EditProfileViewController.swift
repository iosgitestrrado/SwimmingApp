//
//  EditProfileViewController.swift
//  SwimmingApp
//
//  Created by MAC on 09/10/20.
//  Copyright © 2020 Monish M S. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class EditProfileViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var imagePicker = UIImagePickerController()
    var images = [UIImage]()
    var accessToken = ""
    var child_id = ""
    var sProfileName = ""
    var sPhoneNumber = ""
    var sEmailId = ""
    var iSelectdImageUrl = ""
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var txtEmailId: UITextField!
    
    @IBOutlet weak var btnSubmit: BlueShadowButton!
    @IBOutlet weak var btnCancel: ExpansionButton!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var btnCamera: UIButton!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
       

        // Do any additional setup after loading the view.
        
        SetUI()
        
        
        
    }
    func SetUI()
    {
        txtName.text = sProfileName
        imgProfile.layer.cornerRadius = 50.0
        imgProfile.sd_setImage(with: URL(string: iSelectdImageUrl), placeholderImage: UIImage(named: "person"))
        txtEmailId.text = sEmailId
        txtPhoneNumber.text = sPhoneNumber

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
        if let pickedImage = info[.originalImage] as? UIImage
      {
        self.saveImageToDocumentDirectory(image: pickedImage)
        self.imgProfile.image = pickedImage

        let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let nsUserDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
        let imageURL = URL(fileURLWithPath: paths.first!).appendingPathComponent("avthar.png")
        imgProfile.image = info[.originalImage] as? UIImage
        imgProfile.layer.cornerRadius = 50.0
           
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
    
    
    
    @IBAction func ActionCancel(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func ActionSubmit(_ sender: Any)
    {
        if isValidTextFieldsInputs()
        {
            if ((txtEmailId.text?.isValidEmail) != nil)
            {
                
                let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
                let nsUserDomainMask = FileManager.SearchPathDomainMask.userDomainMask
                let paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
                let imageURL = URL(fileURLWithPath: paths.first!).appendingPathComponent("avthar.png")
                
                if let data = UserDefaults.standard.value(forKey: "userData") as? Data{
                    let useObj = try? PropertyListDecoder().decode(UserModel.self,from: data)
                    accessToken = (useObj?.access_token)!
                }
                hudControllerClass.showNormalHudToViewController(viewController: self)
                weak var weakSelf = self
                
                print(imgProfile.image)
                
                let thumb1 = imgProfile.image!.resized(withPercentage: 0.1)
                var imgData = thumb1!.pngData()
                let imgName = imageURL.lastPathComponent
                print(imageURL.lastPathComponent) // get file Name
                print(imageURL.pathExtension)   // get file extension
                print("imageName:\(imgName)")
                
                let sPhoneNumber = txtPhoneNumber.text
                let sEmail = txtEmailId.text
                let sName = txtName.text

//                let parameters = ["accesToken" : accessToken,"activity_id" : ssele,"email" :  sEmail,"name" : sName,"child_id" : child_id]
                
                var parameters : [String:String] = [:]
                parameters["accesToken"] = accessToken
                parameters["phone"] = txtPhoneNumber.text
                parameters["email"] = txtEmailId.text
                parameters["name"] = txtName.text
                parameters["child_id"] = child_id

                let url = webServiceUrls.profileUpdateUrl

                
                
                
                Alamofire.upload(multipartFormData: { (multipartFormData) in
                  for (key, value) in parameters {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                  }
                  if let data = imgData
                  {
                   multipartFormData.append(imgData!, withName: "avthar", fileName: imgName , mimeType: "jpg/png")
                  }
                }, usingThreshold: UInt64.init(), to: url, method: .post ,headers: nil ) { (result) in
                  switch result{
                  case .success(let upload, _, _):
                    upload.responseJSON { response in
                 let statValue = response.response?.statusCode
                 if statValue == 200
                   {
                    hudControllerClass.hideHudInViewController(viewController: weakSelf!)
                    self.showPopUp(message: "Profile Updated successfully")
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
            else
            {
                self.showPopUp(message: "Please enter valid email")
            }
        }
        else
        {
            self.showPopUp(message: "Please fill all required fields")
        }
    }
    @IBAction func ActionCamera(_ sender: Any)
    {
        
        
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        
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
        imgProfile.layer.cornerRadius = 50.0

        self.present(alert, animated: true, completion: nil)
    }
    

  
    func isValidTextFieldsInputs() -> Bool
    {
           
               var allValidField = true
        if txtEmailId.text?.isEmpty == true || txtEmailId.text == nil  || txtEmailId.text == "0"
        {
            txtEmailId.becomeFirstResponder()
                   allValidField = false
        }
                   
               else if txtName.text?.isEmpty == true || txtName.text == nil || txtName.text == "0"
               {
                txtName.becomeFirstResponder()

                   allValidField = false
               }
               else if txtPhoneNumber.text?.isEmpty == true || txtPhoneNumber.text == nil || txtPhoneNumber.text == "0"
               {
                txtPhoneNumber.becomeFirstResponder()

                   allValidField = false
               }
               return allValidField
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
extension UIImage {
    func resized(withPercentage percentage: CGFloat, isOpaque: Bool = true) -> UIImage? {
        let canvas = CGSize(width: size.width * percentage, height: size.height * percentage)
        let format = imageRendererFormat
        format.opaque = isOpaque
        return UIGraphicsImageRenderer(size: canvas, format: format).image {
            _ in draw(in: CGRect(origin: .zero, size: canvas))
        }
    }
    func resized(toWidth width: CGFloat, isOpaque: Bool = true) -> UIImage? {
        let canvas = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        let format = imageRendererFormat
        format.opaque = isOpaque
        return UIGraphicsImageRenderer(size: canvas, format: format).image {
            _ in draw(in: CGRect(origin: .zero, size: canvas))
        }
    }
}
