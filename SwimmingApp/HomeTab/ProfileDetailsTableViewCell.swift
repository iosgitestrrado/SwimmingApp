//
//  ProfileDetailsTableViewCell.swift
//  SwimmingApp
//
//  Created by MAC on 12/10/20.
//  Copyright © 2020 Monish M S. All rights reserved.
//

import UIKit

class ProfileDetailsTableViewCell: UITableViewCell {
    @IBOutlet weak var imgProfile: UIImageView!
    
    @IBOutlet weak var viewBase: UIView!
    @IBOutlet weak var lblRemainingActivities: UILabel!
    @IBOutlet weak var lblCompletedActivities: UILabel!
    @IBOutlet weak var lblSelectedUsers: UILabel!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var lblName: UILabel!
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
        view1.layer.borderWidth = 3.0
        view2.layer.borderWidth = 3.0
        view3.layer.borderWidth = 3.0
        imgProfile.layer.cornerRadius = 50.0
        viewBase.layer.cornerRadius = 53.0
//        viewBase.layer.borderWidth = 3.0
//        viewBase.layer.borderColor = UIColor.white.cgColor
        view1.layer.borderColor = UIColor.systemBlue.cgColor
        view2.layer.borderColor = UIColor.systemBlue.cgColor
        view3.layer.borderColor = UIColor.systemBlue.cgColor

        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
