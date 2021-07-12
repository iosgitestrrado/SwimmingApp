//
//  LocationListVC.swift
//  SwimmingApp
//
//  Created by Monish M S on 19/07/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

import Foundation
import UIKit
class LocationListVC:UIViewController{
    
    @IBOutlet var header: CommonHeader!
    @IBOutlet var locationTextField: TextField!
    @IBOutlet var locationListTableView: UITableView!
    @IBOutlet var locationView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTable()
    }
    
    func setupUI(){
        header.locationLabel.text = "Location List"
        header.backButton.addTarget(self, action: #selector(self.backButtonAction(_:)), for: .touchUpInside)
        locationView.backgroundColor = UIColor(patternImage: UIImage(named: "loca")!)
    }
    
    func setupTable(){
        locationListTableView.delegate = self
        locationListTableView.dataSource = self
        locationListTableView.register(UINib(nibName: "LocationListVCCell", bundle: nil), forCellReuseIdentifier: "LocationListVCCell")
        locationListTableView.rowHeight = UITableView.automaticDimension
        locationListTableView.separatorStyle = .none
        
    }
    
    @objc func backButtonAction(_ button:UIButton){
        self.navigationController?.popViewController(animated: false)
    }
    
    @objc func selectedLocationAction(_ button:UIButton){
        self.performSegue(withIdentifier: "segueToHomeDashBoard", sender: nil)
    }
}

extension LocationListVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = locationListTableView.dequeueReusableCell(withIdentifier: "LocationListVCCell") as! LocationListVCCell
        cell.SelectedLocationButton.addTarget(self, action: #selector(selectedLocationAction(_:)), for: .touchUpInside)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "segueToHomeDashBoard", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

