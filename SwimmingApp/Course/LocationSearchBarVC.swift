//
//  LocationSearchBarVC.swift
//  SwimmingApp
//
//  Created by Monish M S on 26/09/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

protocol updateLocationProtocol:class{
    func locationInfo(id:String,name:String)
}

import Foundation
import UIKit
class LocationSearchBarVC:UIViewController,UISearchControllerDelegate,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var locationListTableView: UITableView!
    
    var locationList = [LocationModel]()
    var filteredData = [LocationModel]()
    weak var delegate : updateLocationProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        setupTable()
        setupSearchBar()
    }
    
    func setupTable(){
        locationListTableView.rowHeight = UITableView.automaticDimension
        locationListTableView.layer.cornerRadius = 10.0
       
    }
    
    func setupSearchBar(){
        searchBar.delegate = self
        filteredData = locationList
        searchBar.placeholder = "Search"
        searchBar.returnKeyType = .done
        searchBar.enablesReturnKeyAutomatically = false
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        if touch?.view != locationListTableView && touch?.view != searchBar {
            self.tabBarController?.tabBar.isHidden = false
            self.view.removeFromSuperview()
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationSearchBarTableViewCell", for: indexPath) as! LocationSearchBarTableViewCell
        cell.locLabel.text = filteredData[indexPath.row].locName
        cell.layer.cornerRadius = 5.0
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.locationInfo(id: String(filteredData[indexPath.row].id), name: filteredData[indexPath.row].locName!)
        self.view.removeFromSuperview()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}



extension LocationSearchBarVC:UISearchBarDelegate{
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        self.view.removeFromSuperview()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == ""{
            filteredData.removeAll()
            filteredData = locationList
        }else{
            let filtered  = locationList.filter{ $0.locName!.lowercased().contains(searchText.lowercased()) }
            filteredData = filtered
        }
        locationListTableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.enablesReturnKeyAutomatically = false
        searchBar.resignFirstResponder()
    }
}
