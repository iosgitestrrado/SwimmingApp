//
//  MilestoneInnerListVCThree.swift
//  SwimmingApp
//
//  Created by Monish M S on 27/09/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

import Foundation
import UIKit
class MilestoneInnerListVCThree:UIViewController, SelectedChildDetailsDelegate
{
    
    
    
    @IBOutlet var innerTableView: UITableView!
    @IBOutlet var header: CommonHeader!
    
    
    var row:Int = 0
    var avtGroupsList = [AvtGroupsModel]()
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
    func setupUI(){

        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        innerTableView.separatorStyle = .none
        header.locationLabel.text = "Explore"
        header.profileNameLabel.text = (UserDefaults.standard.value(forKey: "name") as! String)
        header.imgProfile.sd_setImage(with: URL(string: (UserDefaults.standard.value(forKey: "imgUrl") as! String)), placeholderImage: UIImage(named: "person"))
        header.btnChildPopUp.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)

        header.backButton.addTarget(self, action: #selector(backButtonTapped(_:)), for: .touchUpInside)
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
}
extension MilestoneInnerListVCThree:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = innerTableView.dequeueReusableCell(withIdentifier: "MileStoneActivityListingTableViewCellTwo") as! MileStoneActivityListingTableViewCellTwo
            cell.descriptionLabel.text = activitiesListTwo?.activity_desc!
            cell.mediaList = (activitiesListTwo?.media!)!
            cell.frame = tableView.bounds
            cell.layoutIfNeeded()
            cell.acivityListingCollectionViewHeight.constant = cell.activityCollectionView.collectionViewLayout.collectionViewContentSize.height
            cell.selectionStyle = .none
            return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = color
        
        let headerLabel = UILabel(frame: CGRect(x: 8, y: 8, width:
            tableView.bounds.size.width, height: tableView.bounds.size.height))
        headerLabel.font = UIFont(name: "Verdana", size: 17)
        headerLabel.textColor = UIColor.white
        headerLabel.text = activitiesListTwo?.activity_name
        headerLabel.sizeToFit()
        headerView.addSubview(headerLabel)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}






