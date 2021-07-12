//
//  AddChildPopUpTableViewCell.swift
//  SwimmingApp
//
//  Created by MAC on 16/10/20.
//  Copyright © 2020 Monish M S. All rights reserved.
//

import UIKit

class AddChildNameTableViewCell: UITableViewCell
{

    @IBOutlet weak var txtMobileNumber: UITextField!
    @IBOutlet weak var txtAddChildName: UITextField!
    
    @IBOutlet weak var txtRelation: UITextField!
    @IBOutlet weak var txtEmailId: UITextField!
    
    @IBOutlet weak var btnAddChild: BlueShadowButton!
    override func awakeFromNib()
    
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
