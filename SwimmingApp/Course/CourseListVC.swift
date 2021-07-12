//
//  CourseListVC.swift
//  SwimmingApp
//
//  Created by Monish M S on 23/07/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage
class CourseListVC:UIViewController, SelectedChildDetailsDelegate
{
    
    
    
    @IBOutlet var courseListCollectionView: UICollectionView!
    @IBOutlet var header: CommonHeader!
    @IBOutlet var stackViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet var changeButton: UIButton!
    @IBOutlet var locationTextView: UITextView!
    @IBOutlet var locationName: UILabel!
    @IBOutlet var noCourseLabel: UILabel!
    @IBOutlet var notifyButton: BlueShadowButton!
    @IBOutlet var selectCourseLabel: UILabel!
    @IBOutlet var notifyButtonHeight: NSLayoutConstraint!
    
    let color = UIColor(red: 53.0/255.0, green: 152.0/255.0, blue: 219.0/255.0, alpha: 1.0)
    var locationId = ""
    var accessToken = ""
    var courseId = ""
    var courseList = [CourseModel]()
    var locationDataObject = LocationDataModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        serviceCallForCourseList()
    }
    
    override func viewDidLayoutSubviews() {
       locationTextView.setContentOffset(CGPoint.zero, animated: false)
    }
    
    func sendSelectedChildDFetailsD(sProfileName: String, sProfileImageName: String, sProfileEmail: String, sProfileMobNumber: String, iSelectedchldId: Int)
    {
        setupUI()
        serviceCallForCourseList()
    }
    
    func setupUI(){
        self.navigationController?.navigationBar.isHidden = true
        header.locationLabel.text = "Explore"
        header.profileNameLabel.text = (UserDefaults.standard.value(forKey: "name") as! String)
        header.imgProfile.sd_setImage(with: URL(string: (UserDefaults.standard.value(forKey: "imgUrl") as! String)), placeholderImage: UIImage(named: "person"))
        header.btnChildPopUp.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)

        header.backButton.addTarget(self, action: #selector(backButtonTapped(_:)), for: .touchUpInside)
        stackViewBottomConstraint.constant = (self.tabBarController?.tabBar.frame.height)!+18
        changeButton.moveImageLeftTextCenter(imagePadding: 5)
       
    }
    @objc func buttonAction(sender: UIButton)
    {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let popupVC = storyBoard.instantiateViewController(withIdentifier: "ChildPopUpViewController") as! ChildPopUpViewController
        popupVC.SelectedChildDetailsDelegate = self
        self.addChild(popupVC)
        self.view.addSubview(popupVC.view)
        popupVC.didMove(toParent: self)

    }
    
    func setupLocationInfo(){
        locationName.text = locationDataObject.name
        locationTextView.text = locationDataObject.description
    }
    
    func setupView(){
        if courseList.count == 0{
            notifyButton.isHidden = false
            notifyButtonHeight.constant = 30
            noCourseLabel.isHidden = false
            selectCourseLabel.isHidden = true
        }else{
            notifyButton.isHidden = true
            notifyButtonHeight.constant = 0
            noCourseLabel.isHidden = true
            selectCourseLabel.isHidden = false
        }
        self.view.layoutIfNeeded()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segueToCourseDetailsVC") {
            if let nextViewController = segue.destination as? CourseDetailsVC {
                nextViewController.courseId = courseId
                nextViewController.accessToken = accessToken
            }
        }
    }
    
    @objc func backButtonTapped(_ button:UIButton){
        self.navigationController?.popViewController(animated: false)
    }
    
    @objc func viewDetailsButtonTapped(_ button:UIButton){
        courseId = String(courseList[button.tag].id)
        self.performSegue(withIdentifier: "segueToCourseDetailsVC", sender: nil)
    }
    
    @IBAction func changeButtonTapped(_ sender: Any) {
       self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func notifyButtonTapped(_ sender: Any) {
        
    }
}
extension CourseListVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return courseList.count
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CourseListCollectionViewCell", for: indexPath as IndexPath) as! CourseListCollectionViewCell
        cell.courseName.text = courseList[indexPath.row].course_name
        cell.milestoneAndActivityLabel.text = String(courseList[indexPath.row].milestones)+" Milestones"+"    "+String(courseList[indexPath.row].activities)+" Activities"
        cell.imageView!.sd_setImage(with: URL(string: courseList[indexPath.row].media!.file!), placeholderImage: UIImage(named: "swim-child.png"))
        cell.viewDetailsButton.tag = indexPath.row
        cell.viewDetailsButton.addTarget(self, action: #selector(viewDetailsButtonTapped(_:)), for: .touchUpInside)
        cell.viewDetailsButton.layer.cornerRadius = 10
        cell.layer.cornerRadius = 10
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = collectionView.bounds.width/1.7
        let yourHeight = collectionView.frame.height
        
        return CGSize(width: yourWidth, height: yourHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        courseId = String(courseList[indexPath.row].id)
        self.performSegue(withIdentifier: "segueToCourseDetailsVC", sender: nil)
    }
}

extension CourseListVC{
    func serviceCallForCourseList(){
        hudControllerClass.showNormalHudToViewController(viewController: self)
        weak var weakSelf = self
        WebServiceApi.courseList(accessToken: accessToken, id: locationId, onSuccess: { (result) in
            
            hudControllerClass.hideHudInViewController(viewController: weakSelf!)
            
            if let status = result["status"] as? String {
                if status == "success"{
                    if let dat = result["data"]{
                        do {
                            let jsonData = try JSONSerialization.data(withJSONObject: dat, options: .prettyPrinted)
                            let reqJSONStr = String(data: jsonData, encoding: .utf8)
                            let datas = reqJSONStr?.data(using: .utf8)
                            let jsonDecoder = JSONDecoder()
                            do {
                                let courObj = try jsonDecoder.decode(CourseListModel.self, from: datas!)
                                self.courseList = courObj.course_list
                                self.locationDataObject = courObj.location!
                                self.setupLocationInfo()
                                self.setupView()
                                 self.courseListCollectionView.reloadData()
                            } catch let parseError {
                                print("failed CourseModel decoding = \(parseError.localizedDescription)")
                            }
                        }
                        catch {
                            print("failed CourseModel JSON Serialiation")
                        }
                    }
                    
                }else{
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

