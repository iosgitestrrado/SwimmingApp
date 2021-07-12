//
//  MilestoneInnerListVCOne.swift
//  SwimmingApp
//
//  Created by Monish M S on 27/09/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

import Foundation
import UIKit
class MilestoneInnerListVCOne:UIViewController, SelectedChildDetailsDelegate{
   
    
    
    @IBOutlet var innerCollectionView: UICollectionView!
    @IBOutlet var header: CommonHeader!
    
    var milestoneList = [mstoneModel]()
    var avtGroupsList = [AvtGroupsModel]()
    var activitiesList = [ActivitiesModel]()
    var row:Int = 0
    var rowOne:Int = 0
    let color = UIColor(red: 1.0/255.0, green: 180.0/255.0, blue: 221.0/255.0, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    func sendSelectedChildDFetailsD(sProfileName: String, sProfileImageName: String, sProfileEmail: String, sProfileMobNumber: String, iSelectedchldId: Int)
    {
        setupUI()

    }
    override func viewWillAppear(_ animated: Bool) {
        print("row====\(row)")
    }
    
    func setupUI(){
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        header.locationLabel.text = "Explore"
        header.profileNameLabel.text = (UserDefaults.standard.value(forKey: "name") as! String)
        header.imgProfile.sd_setImage(with: URL(string: (UserDefaults.standard.value(forKey: "imgUrl") as! String)), placeholderImage: UIImage(named: "person"))
        header.btnChildPopUp.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)

        header.backButton.addTarget(self, action: #selector(backButtonTapped(_:)), for: .touchUpInside)
    }
    
    @objc func backButtonTapped(_ button:UIButton){
        self.navigationController?.popViewController(animated: false)
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segueToInnerListVCTwo") {
            if let nextViewController = segue.destination as? MilestoneInnerListVCTwo {
                nextViewController.row = rowOne
                nextViewController.avtGroupsList = avtGroupsList
                nextViewController.activitiesList = activitiesList
            }
        }
    }
    
}
//extension MilestoneInnerListVCOne:UITableViewDelegate,UITableViewDataSource{
//
//    func numberOfSections(in tableView: UITableView) -> Int
//    {
//        if milestoneList[row].avtGroups!.count > 0 && milestoneList[row].activities!.count > 0
//        {
//            return 2
//        }
//        else if milestoneList[row].avtGroups!.count > 0 || milestoneList[row].activities!.count > 0
//        {
//            return 1
//        }
//        else
//        {
//            return 0
//        }
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if section == 0{
//            if milestoneList[row].avtGroups!.count > 0{
//               return milestoneList[row].avtGroups!.count
//            }else{
//                return milestoneList[row].activities!.count
//            }
//        }else{
//            return milestoneList[row].activities!.count
//        }
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if indexPath.section == 0
//        {
//          if milestoneList[row].avtGroups!.count > 0
//          {
//            let cell = innerTableView.dequeueReusableCell(withIdentifier: "MilestonesTableViewCell") as! MilestonesTableViewCell
//            var avtGroups = [AvtGroupsModel]()
//            avtGroups = milestoneList[row].avtGroups!
//            cell.MileStonesLabel.text = avtGroups[indexPath.row].group_name
//            cell.selectionStyle = .none
//            return cell
//          }else{
//            let cell = innerTableView.dequeueReusableCell(withIdentifier: "MilestonesTableViewCell") as! MilestonesTableViewCell
//            var activts = [ActivitiesModel]()
//            activts = milestoneList[row].activities!
//            cell.MileStonesLabel.text = activts[indexPath.row].activity_name
//            cell.selectionStyle = .none
//            return cell
//          }
//        }else{
//            let cell = innerTableView.dequeueReusableCell(withIdentifier: "MilestonesTableViewCell") as! MilestonesTableViewCell
//            var activts = [ActivitiesModel]()
//            activts = milestoneList[row].activities!
//            cell.MileStonesLabel.text = activts[indexPath.row].activity_name
//            cell.selectionStyle = .none
//            return cell
//        }
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
//{
//
//        if indexPath.section == 0{
//            if milestoneList[row].avtGroups!.count > 0{
//                avtGroupsList = milestoneList[row].avtGroups!
//            }else{
//                activitiesList = milestoneList[row].activities!
//            }
//        }else{
//            avtGroupsList.removeAll()
//            activitiesList = milestoneList[row].activities!
//        }
//        rowOne = indexPath.row
//        self.performSegue(withIdentifier: "segueToInnerListVCTwo", sender: nil)
//
//    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 50
//    }
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = UIView()
//        headerView.backgroundColor = color
//
//        let headerLabel = UILabel(frame: CGRect(x: 8, y: 8, width:
//            tableView.bounds.size.width, height: tableView.bounds.size.height))
//        headerLabel.font = UIFont(name: "Verdana", size: 17)
//        headerLabel.textColor = UIColor.white
//        if section == 0{
//            if milestoneList[row].avtGroups!.count > 0{
//                 headerLabel.text = "Groups"
//            }else{
//                 headerLabel.text = "Activities"
//            }
//        }else{
//            headerLabel.text = "Activities"
//        }
//
//        headerLabel.sizeToFit()
//        headerView.addSubview(headerLabel)
//
//        return headerView
//    }
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 40
//    }
//}

extension MilestoneInnerListVCOne:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    
  
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if milestoneList[row].avtGroups!.count > 0
        {
           return milestoneList[row].avtGroups!.count
        }
        else
        {
            return milestoneList[row].activities!.count
        }
        
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if indexPath.section == 0
        {
          if milestoneList[row].avtGroups!.count > 0
          {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MileStoneInnerListOneCollectionViewCell", for: indexPath as IndexPath) as! MileStoneInnerListOneCollectionViewCell
            cell.imageMileStone.layer.cornerRadius = cell.imageMileStone.bounds.height/2
            var avtGroups = [AvtGroupsModel]()
            avtGroups = milestoneList[row].avtGroups!
            cell.lblMileStone.text = avtGroups[indexPath.row].group_name
            return cell
          }
          else
          {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MileStoneInnerListOneCollectionViewCell", for: indexPath as IndexPath) as! MileStoneInnerListOneCollectionViewCell
            var activts = [ActivitiesModel]()
            cell.imageMileStone.layer.cornerRadius = cell.imageMileStone.bounds.height/2
            activts = milestoneList[row].activities!
            cell.lblMileStone.text = activts[indexPath.row].activity_name
            return cell
          }
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MileStoneInnerListOneCollectionViewCell", for: indexPath as IndexPath) as! MileStoneInnerListOneCollectionViewCell
            var activts = [ActivitiesModel]()
            cell.imageMileStone.layer.cornerRadius = cell.imageMileStone.bounds.height/2
            activts = milestoneList[row].activities!
            cell.lblMileStone.text = activts[indexPath.row].activity_name
            return cell
        }
    }
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
      

return CGSize(width: 125, height: 125)
}
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets.zero
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//
   
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        // handle tap events
                if indexPath.section == 0
                {
                    if milestoneList[row].avtGroups!.count > 0
                    {
                        avtGroupsList = milestoneList[row].avtGroups!
                    }
                    else
                    {
                        activitiesList = milestoneList[row].activities!
                    }
                }
                else
                {
                    avtGroupsList.removeAll()
                    activitiesList = milestoneList[row].activities!
                }
        rowOne = indexPath.row
        self.performSegue(withIdentifier: "segueToInnerListVCTwo", sender: nil)
        
    }
}




