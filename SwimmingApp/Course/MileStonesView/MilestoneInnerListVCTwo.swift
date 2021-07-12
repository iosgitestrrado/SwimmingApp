//
//  MilestoneInnerListVCTwo.swift
//  SwimmingApp
//
//  Created by Monish M S on 27/09/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

import Foundation
import UIKit
class MilestoneInnerListVCTwo:UIViewController, SelectedChildDetailsDelegate
{
    
    
    
    @IBOutlet var innerTableView: UITableView!
    @IBOutlet var header: CommonHeader!
    
    
    var row:Int = 0
    var rowOne:Int = 0
    var avtGroupsList = [AvtGroupsModel]()
    var groupActivitiesList = [ActivitiesModel]()
    var activitiesList = [ActivitiesModel]()
    var activitiesListTwo : ActivitiesModel?
    let color = UIColor(red: 1.0/255.0, green: 180.0/255.0, blue: 221.0/255.0, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    func sendSelectedChildDFetailsD(sProfileName: String, sProfileImageName: String, sProfileEmail: String, sProfileMobNumber: String, iSelectedchldId: Int)
    {
        setupUI()

    }
    func setupUI()
    {
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        innerTableView.separatorStyle = .none
        innerTableView.register(UINib(nibName: "MilestonesTableViewCell", bundle: nil), forCellReuseIdentifier: "MilestonesTableViewCell")
        innerTableView.delegate = self
        innerTableView.dataSource = self
        header.locationLabel.text = "Explore"
        header.profileNameLabel.text = (UserDefaults.standard.value(forKey: "name") as! String)
        header.imgProfile.sd_setImage(with: URL(string: (UserDefaults.standard.value(forKey: "imgUrl") as! String)), placeholderImage: UIImage(named: "person"))
        header.btnChildPopUp.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)

        header.backButton.addTarget(self, action: #selector(backButtonTapped(_:)), for: .touchUpInside)
        if avtGroupsList.count > 0{
            groupActivitiesList = avtGroupsList[row].activities!
        }
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
    @objc func backButtonTapped(_ button:UIButton){
        self.navigationController?.popViewController(animated: false)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segueToMilestoneInerList3") {
            if let nextViewController = segue.destination as? MilestoneInnerListVCThree {
                nextViewController.activitiesListTwo = activitiesListTwo
            }
        }
    }
}

extension MilestoneInnerListVCTwo:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if avtGroupsList.count > 0{
            return groupActivitiesList.count
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            if avtGroupsList.count > 0{
                let cell = innerTableView.dequeueReusableCell(withIdentifier: "MilestonesTableViewCell") as! MilestonesTableViewCell
                cell.MileStonesLabel.text = groupActivitiesList[indexPath.row].activity_name
                cell.selectionStyle = .none
                return cell
            }else{
                let cell = innerTableView.dequeueReusableCell(withIdentifier: "MileStoneActivityListingTableViewCell") as! MileStoneActivityListingTableViewCell
                cell.descriptionLabel.text = activitiesList[row].activity_desc!
                cell.mediaList = activitiesList[row].media!
                cell.frame = tableView.bounds
                cell.layoutIfNeeded()
                cell.acivityListingCollectionViewHeight.constant = cell.activityCollectionView.collectionViewLayout.collectionViewContentSize.height
                cell.selectionStyle = .none
                return cell
            }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if avtGroupsList.count > 0{
            activitiesListTwo = groupActivitiesList[indexPath.row]
            rowOne = indexPath.row
            self.performSegue(withIdentifier: "segueToMilestoneInerList3", sender: nil)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         if avtGroupsList.count > 0{
            return 50
         }
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.white
        let headerLabel = UILabel(frame: CGRect(x: 8, y: 8, width:
            tableView.bounds.size.width, height: tableView.bounds.size.height))
        headerLabel.font = UIFont(name: "Verdana", size: 17)
        headerLabel.textColor = UIColor.black
        if avtGroupsList.count > 0{
            headerLabel.text = "Activities"
        }else{
            headerLabel.text = activitiesList[row].activity_name
        }
        
        
        headerLabel.sizeToFit()
        headerView.addSubview(headerLabel)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}




