//
//  ActivityListingVC.swift
//  SwimmingApp
//
//  Created by Monish M S on 25/07/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

import Foundation
import UIKit
class ActivityListingVC:UIViewController,SelectedChildDetailsDelegate
{
    
    
    @IBOutlet var activityListTableView: UITableView!
    @IBOutlet var activityCollectionView: UICollectionView!
    @IBOutlet var nextActivityButton: UIButton!
    @IBOutlet var pastActivityButton: UIButton!
    @IBOutlet var ActivitiesView: UIView!
    @IBOutlet var header: CommonHeader!
    
    var MenuListItemArray = ["Warm Up","Breathe","Float","Breast Stroke","Free Style"]
    var menuItemTapped = [Int:Bool]()
    var nextActivitiesDetailedTapped:Bool = false
    var pastActivitiesTapped:Bool = false
    var pastActivitiesDetailedTapped:Bool = false
    let color = UIColor(red: 53.0/255.0, green: 152.0/255.0, blue: 219.0/255.0, alpha: 1.0)
    var button = UIButton()
    var buttonTitleArray = [Int:Bool]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        changeVisibility()
    }
    
    func sendSelectedChildDFetailsD(sProfileName: String, sProfileImageName: String, sProfileEmail: String, sProfileMobNumber: String, iSelectedchldId: Int)
    {
        
        setupUI()
        changeVisibility()
    }
    
    
    func setupUI()
    {
        activityListTableView.register(UINib(nibName: "ActivityListingVCCell", bundle: nil), forCellReuseIdentifier: "ActivityListingVCCell")
        
        activityListTableView.register(UINib(nibName: "NextActivityDetailedVCCell", bundle: nil), forCellReuseIdentifier: "NextActivityDetailedVCCell")
        
        activityListTableView.register(UINib(nibName: "PastActivityVCCell", bundle: nil), forCellReuseIdentifier: "PastActivityVCCell")
        
        activityListTableView.register(UINib(nibName: "PastActivityDetailedVCCell", bundle: nil), forCellReuseIdentifier: "PastActivityDetailedVCCell")
        
        activityListTableView.rowHeight = UITableView.automaticDimension
        ActivitiesView.layer.cornerRadius = 20
        nextActivityButton.backgroundColor = UIColor.black
        nextActivityButton.layer.cornerRadius = 20
        nextActivityButton.layer.maskedCorners = [.layerMinXMinYCorner,.layerMinXMaxYCorner]
        
        button = UIButton(frame: CGRect(x: 0, y: self.view.frame.maxY-20, width: 150, height: 150))
        self.view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true
        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.bottomAnchor.constraint(equalTo: self.activityListTableView.bottomAnchor, constant: 0).isActive = true
        let buttonImage = UIImage(named: "add_min") as UIImage?
        button.setImage(buttonImage, for: .normal)
        header.btnChildPopUp.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
        
        header.backButtonWidth.constant = 0
        header.locationLabel.text = "Activiy"
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
    
    func changeVisibility(){
        for index in 0 ..< MenuListItemArray.count{
            menuItemTapped[index] = false
            buttonTitleArray[index] = false
        }
        menuItemTapped[0] = true
    }
    
    @objc func menuItemTapped(_ recognizer:UITapGestureRecognizer){
        for index in 0 ..< MenuListItemArray.count{
            if index == recognizer.view!.tag{
                menuItemTapped[index] = true
                //cell.menuView.isHidden = false
            }else{
                menuItemTapped[index] = false
                //cell.menuView.isHidden = false
            }
        }
        activityCollectionView.reloadData()
    }
    
    @IBAction func nextActivitiesButtonTapped(_ sender: Any) {
        nextActivityButton.layer.cornerRadius = 20
        nextActivityButton.layer.maskedCorners = [.layerMinXMinYCorner,.layerMinXMaxYCorner]
        nextActivityButton.backgroundColor = UIColor.black
        pastActivityButton.backgroundColor = UIColor.white
        pastActivityButton.setTitleColor(UIColor.black, for: .normal)
        nextActivityButton.setTitleColor(UIColor.white, for: .normal)
        nextActivitiesDetailedTapped = false
        pastActivitiesTapped = false
        pastActivitiesDetailedTapped = false
        button.isHidden = false
        activityListTableView.reloadData()
    }
    
    @IBAction func pastActivitiesButtonTapped(_ sender: Any) {
        pastActivityButton.layer.cornerRadius = 20
        pastActivityButton.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMaxXMaxYCorner]
        nextActivityButton.backgroundColor = UIColor.white
        pastActivityButton.backgroundColor = UIColor.black
        pastActivityButton.setTitleColor(UIColor.white, for: .normal)
        nextActivityButton.setTitleColor(UIColor.black, for: .normal)
        pastActivitiesTapped = true
        pastActivitiesDetailedTapped = false
        nextActivitiesDetailedTapped = false
        button.isHidden = true
        activityListTableView.reloadData()
    }
}
extension ActivityListingVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !nextActivitiesDetailedTapped && !pastActivitiesTapped && !pastActivitiesDetailedTapped{
           return 2
        }else if nextActivitiesDetailedTapped && !pastActivitiesTapped && !pastActivitiesDetailedTapped{
           return 1
        }else if !nextActivitiesDetailedTapped && pastActivitiesTapped && !pastActivitiesDetailedTapped{
            return 2
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var activityCell = ActivityListingVCCell()
        var activityDetailedCell = NextActivityDetailedVCCell()
        var pastActivityCell = PastActivityVCCell()
        var pastActivityDetailedCell = PastActivityDetailedVCCell()
        if !nextActivitiesDetailedTapped && !pastActivitiesTapped && !pastActivitiesDetailedTapped{
            activityCell = activityListTableView.dequeueReusableCell(withIdentifier: "ActivityListingVCCell") as! ActivityListingVCCell
            activityCell.middleView.layer.cornerRadius = activityCell.middleView.frame.size.width / 2
            activityCell.middleView.clipsToBounds = true
            activityCell.middleView.layer.borderColor = UIColor.lightGray.cgColor
            activityCell.middleView.layer.borderWidth = 2
            activityCell.topView.layer.cornerRadius = activityCell.topView.frame.size.width / 2
            activityCell.topView.clipsToBounds = true
            activityCell.topView.layer.borderColor = UIColor.lightGray.cgColor
            activityCell.topView.layer.borderWidth = 5
            activityListTableView.separatorStyle = .singleLine
            return activityCell
        }else if nextActivitiesDetailedTapped && !pastActivitiesTapped && !pastActivitiesDetailedTapped{
            activityDetailedCell = activityListTableView.dequeueReusableCell(withIdentifier: "NextActivityDetailedVCCell") as! NextActivityDetailedVCCell
            activityDetailedCell.remarksTextView.layer.borderColor = UIColor.lightGray.cgColor
            activityDetailedCell.remarksTextView.layer.borderWidth = 2
            activityListTableView.separatorStyle = .none
            return activityDetailedCell
        }else if !nextActivitiesDetailedTapped && pastActivitiesTapped && !pastActivitiesDetailedTapped{
            pastActivityCell = activityListTableView.dequeueReusableCell(withIdentifier: "PastActivityVCCell") as! PastActivityVCCell
            activityListTableView.separatorStyle = .singleLine
            return pastActivityCell
        }
        else{
            pastActivityDetailedCell = activityListTableView.dequeueReusableCell(withIdentifier: "PastActivityDetailedVCCell") as! PastActivityDetailedVCCell
            activityListTableView.separatorStyle = .none
            return pastActivityDetailedCell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        nextActivitiesDetailedTapped = true
        button.isHidden = true
        activityListTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
extension ActivityListingVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let menuCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeTopMenuCollectionViewCell", for: indexPath as IndexPath) as! HomeTopMenuCollectionViewCell
        menuCell.menuName.text = MenuListItemArray[indexPath.row]
        menuCell.menuName.isUserInteractionEnabled = true
        menuCell.menuName.tag = indexPath.row
        let yourSelfGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(menuItemTapped(_:)))
        menuCell.menuName.addGestureRecognizer(yourSelfGestureRecognizer)
        if menuItemTapped[indexPath.row]!{
            menuCell.menuView.isHidden = false
        }else{
            menuCell.menuView.isHidden = true
        }
        return menuCell
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: collectionView.bounds.height)
    }
    
}
