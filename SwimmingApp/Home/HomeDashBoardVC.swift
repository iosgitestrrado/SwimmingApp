//
//  HomeDashBoardVC.swift
//  SwimmingApp
//
//  Created by Monish M S on 24/07/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

import Foundation
import UIKit
import ABSteppedProgressBar
class HomeDashBoardVC:UIViewController{
    
    @IBOutlet var topCollectionView: UICollectionView!
    @IBOutlet var activitiesCollectionView: UICollectionView!
    @IBOutlet var progressBar: ABSteppedProgressBar!
    @IBOutlet var badgeCollectionView: UICollectionView!
    @IBOutlet var milestoneView: UIView!
    @IBOutlet var header: CommonHeader!
    
    var MenuListItemArray = ["Warm Up","Breathe","Float","Breast Stroke","Free Style"]
    var activityListArray = ["A1","A2","A3","A4","A5","A6"]
    var menuItemTapped = [Int:Bool]()
    let color = UIColor(red: 53.0/255.0, green: 152.0/255.0, blue: 219.0/255.0, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        changeVisibility()
    }
   
    func setupUI(){
        self.navigationController?.navigationBar.isHidden = true
        milestoneView.layer.cornerRadius = 5
        milestoneView.isUserInteractionEnabled = false
        header.backButtonHeight.constant = 0
        header.backButtonWidth.constant = 0
        header.locationLabel.text = "Home"
    }
    
    @objc func backButtonTapped(_ button:UIButton){
        self.navigationController?.popViewController(animated: false)
    }
    
    func changeVisibility(){
        for index in 0 ..< MenuListItemArray.count{
            menuItemTapped[index] = false
        }
        menuItemTapped[0] = true
    }
    
}
extension HomeDashBoardVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var menuCell = HomeTopMenuCollectionViewCell()
        var activityCell = CourseListCollectionViewCell()
        var badgeCell = BadgeCollectionViewCell()
        if collectionView == topCollectionView{
            menuCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeTopMenuCollectionViewCell", for: indexPath as IndexPath) as! HomeTopMenuCollectionViewCell
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
        }else if collectionView == activitiesCollectionView{
            activityCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CourseListCollectionViewCell", for: indexPath as IndexPath) as! CourseListCollectionViewCell
//            activityCell.courseName.text = "Activity Name"
//            activityCell.activityNameLabel.text = activityListArray[indexPath.row]
//            activityCell.middleView.layer.cornerRadius = activityCell.middleView.frame.size.width / 2
//            activityCell.middleView.clipsToBounds = true
//            activityCell.middleView.layer.borderColor = color.cgColor
//            activityCell.middleView.layer.borderWidth = 2
//            activityCell.topView.layer.cornerRadius = activityCell.topView.frame.size.width / 2
//            activityCell.topView.clipsToBounds = true
//            activityCell.topView.layer.borderColor = color.cgColor
//            activityCell.topView.layer.borderWidth = 5
            return activityCell
        }else{
            badgeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "BadgeCollectionViewCell", for: indexPath as IndexPath) as! BadgeCollectionViewCell
            badgeCell.badgeTopView.layer.cornerRadius = 5
            return badgeCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == badgeCollectionView{
            let yourWidth = (collectionView.bounds.width/3.0)
            let yourHeight = yourWidth
            return CGSize(width: yourWidth, height: yourHeight)
        }else if collectionView == topCollectionView{
           return CGSize(width: 120, height: collectionView.bounds.height)
        }
        return CGSize(width: collectionView.bounds.height/1.8, height: collectionView.bounds.height)
    }
    
    @objc func menuItemTapped(_ recognizer:UITapGestureRecognizer){
        for index in 0 ..< MenuListItemArray.count{
            if index == recognizer.view!.tag{
                menuItemTapped[index] = true
            }else{
                menuItemTapped[index] = false
            }
        }
        topCollectionView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("taaapppeeedd")
        self.tabBarController?.selectedIndex = 0
    }
    
}
