//
//  RelationshipsPopupVC.swift
//  SwimmingApp
//
//  Created by Monish M S on 24/09/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

import Foundation
import UIKit

protocol relationshipsProtocol:class{
    func relationshipsResponse(val:String)
}

class RelationshipsPopupVC:UIViewController{
    
    @IBOutlet var relationsTableView: UITableView!
    @IBOutlet var tableHeight: NSLayoutConstraint!
    @IBOutlet var tableWidth: NSLayoutConstraint!
    
    var relationsList = [relationshipsModel]()
    weak var delegate:relationshipsProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
    }
    
    func setupTable(){
        tableHeight.constant = CGFloat(relationsList.count*50)
        tableWidth.constant = tableHeight.constant
        relationsTableView.reloadData()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        if touch?.view != relationsTableView {
            self.view.removeFromSuperview()
        }
    }
}
extension RelationshipsPopupVC:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return relationsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = relationsTableView.dequeueReusableCell(withIdentifier: "relationshipsTableViewCell") as! relationshipsTableViewCell
        cell.relationLabel.text = relationsList[indexPath.row].relation
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didselect")
        self.delegate?.relationshipsResponse(val: relationsList[indexPath.row].relation!)
        self.view.removeFromSuperview()
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
