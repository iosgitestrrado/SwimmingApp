//
//  CourseDetailsVC.swift
//  SwimmingApp
//
//  Created by Monish M S on 26/07/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

import Foundation
import UIKit
class CourseDetailsVC:UIViewController{
    
   
    @IBOutlet var registerButton: BlueShadowButton!
    @IBOutlet var rootStackView: UIStackView!
    @IBOutlet var backButton: UIImageView!
    @IBOutlet var courseImageView: UIImageView!
    @IBOutlet var fromDayLabel: UILabel!
    @IBOutlet var fromMonthLabel: UILabel!
    @IBOutlet var fromYearLabel: UILabel!
    @IBOutlet var toDayLabel: UILabel!
    @IBOutlet var toMonthLabel: UILabel!
    @IBOutlet var toMonthYear: UILabel!
    @IBOutlet var detailedView: UILabel!
    @IBOutlet var courseName: UILabel!
    @IBOutlet var courseDetailsTableViewHeight: NSLayoutConstraint!
    @IBOutlet var mileStonesCollectionView: UICollectionView!
    
    
    
    var PackagePosition:Int = 0
    var courseId:String = ""
    var accessToken = ""
    var bRegistrede = Bool()
    var expansionButtonList = [ExpansionButton]()
    var expandIconButtonList = [UIButton]()
    var courseDetailsSubViewList = [CourseDetailsSubView]()
    var courseDataList:CourseDataModel?
    var milestoneList = [mstoneModel]()
    var mileStoneStackViewList = [UIStackView]()
    var courseDetailsTopView = [UIView]()
    var childRegisteredCourseArray = [String]()
    var button = UIButton()
    var row:Int = 0
    var mileStoneId = ""
    var CourseId = ""

    let color = UIColor(red: 1.0/255.0, green: 180.0/255.0, blue: 221.0/255.0, alpha: 1.0)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        serviceCallForCourseDetailsList()
        
        //setupCourseDetailsExpansionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func setupUI(){
        self.navigationController?.navigationBar.isHidden = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(backButtonTapped))
         courseImageView.isUserInteractionEnabled = true
         courseImageView.addGestureRecognizer(gesture)
         fromDayLabel.adjustsFontSizeToFitWidth = true
        mileStonesCollectionView.allowsMultipleSelection = true
        self.childRegisteredCourseArray = UserDefaults.standard.value(forKey: "CourseArray") as! [String]
         mileStonesCollectionView.reloadData()

    }
    
    func setupView()
    {
        if courseDataList?.registered == 1 || bRegistrede == true
        {
            registerButton.setTitle("Course is already registered", for: .normal)
            registerButton.isUserInteractionEnabled = false
        }
        else
        {
            registerButton.setTitle("Register", for: .normal)
            registerButton.isUserInteractionEnabled = true
        }
        courseName.text = courseDataList?.course_name
        detailedView.text = courseDataList?.course_desc
        var mediaTempList = [MediaDataModel]()
        mediaTempList = (courseDataList?.media)!
        if mediaTempList.count > 0{
           courseImageView!.sd_setImage(with: URL(string: mediaTempList[0].file!), placeholderImage: UIImage(named: "swim-child.png"))
        }
        if courseDataList?.start_date != ""{
            let dateStringArray = courseDataList?.start_date!.components(separatedBy: "-")
            if  dateStringArray!.count >= 3{
                fromDayLabel.text = dateStringArray![2]
                let monthName = DateFormatter().monthSymbols[Int(dateStringArray![1])! - 1]
                let mon = monthName.prefix(3)
                fromMonthLabel.text = String(mon)
                fromYearLabel.text = dateStringArray![0]
            }
        }
        if courseDataList?.end_date != ""{
            let dateStringArray = courseDataList?.end_date!.components(separatedBy: "-")
            if  dateStringArray!.count >= 3{
                toDayLabel.text = dateStringArray![2]
                let monthName = DateFormatter().monthSymbols[Int(dateStringArray![1])! - 1]
                let mon = monthName.prefix(3)
                toMonthLabel.text = String(mon)
                toMonthYear.text = dateStringArray![0]
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segueToMilestoneInnerListOne") {
            if let nextViewController = segue.destination as? MilestoneInnerListVCOne {
                nextViewController.milestoneList = milestoneList
                nextViewController.row = row
            }
        }
    }
    
//    func setupCourseDetailsExpansionView(){
//        for i in 0...3 {
//            let titleButtonSubView = CourseDetailsTitleView.instanceFromNib() as! CourseDetailsTitleView
//            titleButtonSubView.packageName.setTitle("MileStone", for: .normal)
//            titleButtonSubView.packageExpandImageButton.setImage(UIImage(named: "expand_more_white"), for: .normal)
//            titleButtonSubView.packageName.tag = i
//            titleButtonSubView.packageExpandImageButton.tag = i
//            if i == 0{
//                titleButtonSubView.packageName.isExpanded = true
//                PackagePosition = 0
//            }else{
//                titleButtonSubView.packageName.isExpanded = false
//            }
//            titleButtonSubView.packageName.addTarget(self, action: #selector(self.stackViewTapped(_:)), for: .touchUpInside)
//            titleButtonSubView.packageExpandImageButton.addTarget(self, action: #selector(self.stackViewTapped(_:)), for: .touchUpInside)
//            expansionButtonList.append(titleButtonSubView.packageName)
//            expandIconButtonList.append(titleButtonSubView.packageExpandImageButton)
//            courseDetailsTopView.append(titleButtonSubView.courseDetailsTopView)
//
//            let keyPadSV = UIStackView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
//            keyPadSV.translatesAutoresizingMaskIntoConstraints = false
//            keyPadSV.axis = .vertical
//            keyPadSV.spacing = 0.0
//            keyPadSV.alignment = .fill
//            keyPadSV.distribution = .fill
//            keyPadSV.isUserInteractionEnabled = true
//            let subView1 = CourseDetailsSubView.instanceFromNib() as! CourseDetailsSubView
//            keyPadSV.addArrangedSubview(subView1)
//            courseDetailsSubViewList.append(subView1)
//            mileStoneStackViewList.append(keyPadSV)
//            rootStackView.addArrangedSubview(titleButtonSubView)
//            rootStackView.addArrangedSubview(keyPadSV)
//            hideAll(tag: 0)
//            self.view.layoutIfNeeded()
//        }
//
//    }
    
    func setupCourseDetailsExpansionView(){
        for i in 0...3 {
            let titleButtonSubView = CourseDetailsTitleView.instanceFromNib() as! CourseDetailsTitleView
            titleButtonSubView.packageName.setTitle("MileStone", for: .normal)
            titleButtonSubView.packageExpandImageButton.setImage(UIImage(named: "expand_more_white"), for: .normal)
            titleButtonSubView.packageName.tag = i
            titleButtonSubView.packageExpandImageButton.tag = i
            if i == 0{
                titleButtonSubView.packageName.isExpanded = true
                PackagePosition = 0
            }else{
                titleButtonSubView.packageName.isExpanded = false
            }
            titleButtonSubView.packageName.addTarget(self, action: #selector(self.stackViewTapped(_:)), for: .touchUpInside)
            titleButtonSubView.packageExpandImageButton.addTarget(self, action: #selector(self.stackViewTapped(_:)), for: .touchUpInside)
            expansionButtonList.append(titleButtonSubView.packageName)
            expandIconButtonList.append(titleButtonSubView.packageExpandImageButton)
            courseDetailsTopView.append(titleButtonSubView.courseDetailsTopView)
            
            let keyPadSV = UIStackView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            keyPadSV.translatesAutoresizingMaskIntoConstraints = false
            keyPadSV.axis = .vertical
            keyPadSV.spacing = 0.0
            keyPadSV.alignment = .fill
            keyPadSV.distribution = .fill
            keyPadSV.isUserInteractionEnabled = true
            let subView1 = CourseDetailsSubView.instanceFromNib() as! CourseDetailsSubView
            keyPadSV.addArrangedSubview(subView1)
            courseDetailsSubViewList.append(subView1)
            mileStoneStackViewList.append(keyPadSV)
            rootStackView.addArrangedSubview(titleButtonSubView)
            rootStackView.addArrangedSubview(keyPadSV)
            hideAll(tag: 0)
            self.view.layoutIfNeeded()
        }
        
    }
    
    @objc func stackViewTapped(_ button:UIButton) {
        print("Tappeddddd\(button.tag)")
        for index in 0 ..< expansionButtonList.count{
            if index == button.tag{
                if expansionButtonList[index].isExpanded{
                    hide(tag: button.tag)
                }else{
                    PackagePosition = button.tag
                    show(tag: button.tag)
                }
            }
        }
    }
    
    func show(tag:Int){
        for index in 0 ..< mileStoneStackViewList.count{
            if index == tag{
                expansionButtonList[index].isExpanded = true
                expansionButtonList[index].backgroundColor = color
                courseDetailsTopView[index].backgroundColor = color
                mileStoneStackViewList[index].isHidden = false
                expandIconButtonList[index].setImage(UIImage(named: "expand_more_white"), for: .normal)
            }else{
                expansionButtonList[index].isExpanded = false
                expansionButtonList[index].backgroundColor = UIColor.lightGray
                courseDetailsTopView[index].backgroundColor = UIColor.lightGray
                mileStoneStackViewList[index].isHidden = true
                expandIconButtonList[index].setImage(UIImage(named: "expand_less_white"), for: .normal)
            }
        }
    }
    
    func hide(tag:Int){
        for index in 0 ..< mileStoneStackViewList.count{
            expansionButtonList[index].isExpanded = false
            expansionButtonList[index].backgroundColor = UIColor.lightGray
            courseDetailsTopView[index].backgroundColor = UIColor.lightGray
            mileStoneStackViewList[index].isHidden = true
            expandIconButtonList[index].setImage(UIImage(named: "expand_less_white"), for: .normal)
        }
    }
    
    func hideAll(tag:Int){
        for index in 0 ..< mileStoneStackViewList.count{
            if index != tag{
                mileStoneStackViewList[index].isHidden = true
                expansionButtonList[index].backgroundColor = UIColor.lightGray
                courseDetailsTopView[index].backgroundColor = UIColor.lightGray
                expandIconButtonList[index].setImage(UIImage(named: "expand_less_white"), for: .normal)
            }else{
                expansionButtonList[index].backgroundColor = color
                courseDetailsTopView[index].backgroundColor = color
                expandIconButtonList[index].setImage(UIImage(named: "expand_more_white"), for: .normal)
            }
        }
    }
    
   
    
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        serviceCallForRegistration()
    }
}

extension CourseDetailsVC{
    func serviceCallForCourseDetailsList(){
        hudControllerClass.showNormalHudToViewController(viewController: self)
        weak var weakSelf = self
        WebServiceApi.courseDetailList(accessToken: accessToken, id: courseId, onSuccess: { [self] (result) in
            
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
                                let courObj = try jsonDecoder.decode(CourseMileStoneModel.self, from: datas!)
                                self.courseDataList = courObj.course
                                self.milestoneList = courObj.mStone!
                                print("MilestoneListCount==\(self.milestoneList.count)")
                                
                                for Coursedata in self.childRegisteredCourseArray
                                    {
                                    
                                    print(Coursedata)
                                    if Coursedata == self.courseDataList?.course_name
                                    {
                                        self.bRegistrede = true
                                    }
                                   
                                }
                                
                                
                                
                                self.setupView()
//                                self.courseDetailsTableViewHeight.constant = CGFloat(self.milestoneList.count*50+40)
                                self.mileStonesCollectionView.reloadData()
                            } catch let parseError {
                                print("failed CourseDetailModel decoding = \(parseError.localizedDescription)")
                            }
                        }
                        catch {
                            print("failed CourseDetailModel JSON Serialiation")
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
    
    func serviceCallForRegistration()
    {
        
        hudControllerClass.showNormalHudToViewController(viewController: self)
        weak var weakSelf = self
        
        var sChildId = "0"
        
        sChildId = UserDefaults.standard.value(forKey: "Child_id") as! String
        
        WebServiceApi.courseRegistration(accesToken: accessToken, course_id: courseId, child_id: sChildId, onSuccess: { (result) in
            
            hudControllerClass.hideHudInViewController(viewController: weakSelf!)
            
            if let status = result["status"] as? String
            {
                if status == "success"
                {
                    self.showPopUpSuccess(message: "Course registered successfully")
                    
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
    
    func showPopUpSuccess(message:String){
        let alert = AlertController.getSingleOptionAlertControllerWithMessage(message: message, titleOfAlert: "SwimmingApp", oktitle:"Done", OkButtonBlock:{ (action)
            in
            self.tabBarController?.selectedIndex = 2
        })
        self.present(alert,animated: false,completion: nil)
    }
}


extension CourseDetailsVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    
  
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.milestoneList.count
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CourseDetailsCollectionViewCell", for: indexPath as IndexPath) as! CourseDetailsCollectionViewCell
        cell.lblMileStone.text = milestoneList[indexPath.row].ms_name
        cell.imgMileStone.layer.cornerRadius = cell.imgMileStone.bounds.height/2
        
        
        return cell
    }
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
let yourWidth = mileStonesCollectionView.bounds.width/1.7
        let yourHeight = mileStonesCollectionView.frame.height

return CGSize(width: yourWidth, height: yourHeight)
}
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
   
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        // handle tap events
        mileStoneId = String(milestoneList[indexPath.row].id!)
        CourseId = String(milestoneList[indexPath.row].course_id!)
        row = indexPath.row
        performSegue(withIdentifier: "segueToMilestoneInnerListOne", sender: nil)
        
    }
}







//
//extension CourseDetailsVC:UITableViewDelegate,UITableViewDataSource{
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return milestoneList.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = mileStonesTableView.dequeueReusableCell(withIdentifier: "MilestonesTableViewCell") as! MilestonesTableViewCell
//        cell.MileStonesLabel.text = milestoneList[indexPath.row].ms_name
//        cell.selectionStyle = .none
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        row = indexPath.row
//        performSegue(withIdentifier: "segueToMilestoneInnerListOne", sender: nil)
//
//    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 50
//    }
//
//     func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = UIView()
//        headerView.backgroundColor = color
//
//        let headerLabel = UILabel(frame: CGRect(x: 8, y: 8, width:
//            tableView.bounds.size.width, height: tableView.bounds.size.height))
//        headerLabel.font = UIFont(name: "Verdana", size: 17)
//        headerLabel.textColor = UIColor.white
//        headerLabel.text = "Milestones"
//        headerLabel.sizeToFit()
//        headerView.addSubview(headerLabel)
//
//        return headerView
//    }
//
//     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 40
//    }
//}
//
