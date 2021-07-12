//
//  AddchildViewController.swift
//  SwimmingApp
//
//  Created by MAC on 09/10/20.
//  Copyright © 2020 Monish M S. All rights reserved.
//

import UIKit

class AddchildViewController: UIViewController,UITableViewDelegate,UITableViewDataSource
{
    
    
    @IBOutlet weak var tbleAddChild: UITableView!
    var accessToken = ""
    var child_id = ""
    
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 330;//Choose your custom row height
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let   cell = tbleAddChild.dequeueReusableCell(withIdentifier: "AddChildNameTableViewCell")!as! AddChildNameTableViewCell
        
          return cell
    }
    

     @IBAction func ActionAddChild(_ sender: Any)
     {
        if isValidTextFieldsInputs()
        {
            let   cell = tbleAddChild.dequeueReusableCell(withIdentifier: "AddChildNameTableViewCell")!as! AddChildNameTableViewCell

            if ((cell.txtEmailId.text?.isValidEmail) != nil)
            {
        
                self.SubmitChildDetails()
                removeAnimate()
                
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
    /*
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func isValidTextFieldsInputs() -> Bool
    {
        let index = IndexPath(row: 0, section: 0)
        let cell: AddChildNameTableViewCell = self.tbleAddChild.cellForRow(at: index) as! AddChildNameTableViewCell

               var allValidField = true
        if cell.txtMobileNumber.text?.isEmpty == true || cell.txtMobileNumber.text == nil  || cell.txtMobileNumber.text == "0"
        {
            cell.txtMobileNumber.becomeFirstResponder()
                   allValidField = false
        }
                   
        else if cell.txtAddChildName.text?.isEmpty == true || cell.txtAddChildName.text == nil || cell.txtAddChildName.text == "0"
               {
            cell.txtAddChildName.becomeFirstResponder()

                   allValidField = false
               }
               else if cell.txtRelation.text?.isEmpty == true || cell.txtRelation.text == nil || cell.txtRelation.text == "0"
               {
                cell.txtRelation.becomeFirstResponder()

                   allValidField = false
               }
               else if cell.txtEmailId.text?.isEmpty == true || cell.txtEmailId.text == nil || cell.txtEmailId.text == "0"
               {
                cell.txtEmailId.becomeFirstResponder()

                   allValidField = false
               }
        
               return allValidField
       }
    
    
    func SubmitChildDetails()
    {
        let index = IndexPath(row: 0, section: 0)
        let cell: AddChildNameTableViewCell = self.tbleAddChild.cellForRow(at: index) as! AddChildNameTableViewCell
        
        if let data = UserDefaults.standard.value(forKey: "userData") as? Data{
            let useObj = try? PropertyListDecoder().decode(UserModel.self,from: data)
            accessToken = (useObj?.access_token)!
        }
        
                
        hudControllerClass.showNormalHudToViewController(viewController: self)
        weak var weakSelf = self
        
        
        var dict: [String:AnyObject] = ["name":cell.txtAddChildName.text as AnyObject,
                                        "phone": cell.txtMobileNumber.text as AnyObject,
                                        "email": cell.txtEmailId.text as AnyObject,
                                        "relation": 1 as AnyObject
         ]
        
        
        WebServiceApi.AddChildApi(accesToken: accessToken, childModelList: [dict],onSuccess: { [self] (result) in
            
            hudControllerClass.hideHudInViewController(viewController: weakSelf!)
            if let status = result["status"] as? String
            {
                if status == "success"
                {
                    
                    self.showPopUp(message:"Chiled has been added successfully!")

                
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
