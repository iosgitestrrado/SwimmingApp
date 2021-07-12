//
//  NotificationListingVC.swift
//  SwimmingApp
//
//  Created by Monish M S on 26/07/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage
class NotificationListingVC:UIViewController,SelectedChildDetailsDelegate
{
    
    
    @IBOutlet var header: CommonHeader!
    @IBOutlet var notificationListingTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         setupTable()
    }
    func sendSelectedChildDFetailsD(sProfileName: String, sProfileImageName: String, sProfileEmail: String, sProfileMobNumber: String, iSelectedchldId: Int)
    {
        setupTable()

    }
    
    func setupTable(){
        header.backButtonWidth.constant = 0
        header.locationLabel.text = "Notifications"
        header.profileNameLabel.text = (UserDefaults.standard.value(forKey: "name") as! String)
        
        header.imgProfile.sd_setImage(with: URL(string: (UserDefaults.standard.value(forKey: "imgUrl") as! String)), placeholderImage: UIImage(named: "person"))

        header.btnChildPopUp.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)

        notificationListingTableView.register(UINib(nibName: "NotificationListingVCCell", bundle: nil), forCellReuseIdentifier: "NotificationListingVCCell")
        notificationListingTableView.rowHeight = UITableView.automaticDimension
        notificationListingTableView.allowsSelection = false
        notificationListingTableView.reloadData()
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
    
}

extension NotificationListingVC:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = notificationListingTableView.dequeueReusableCell(withIdentifier: "NotificationListingVCCell") as! NotificationListingVCCell
        return cell
    }
}
