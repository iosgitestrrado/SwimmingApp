//
//  ActivityDetailsBadgeTableViewCell.swift
//  SwimmingApp
//
//  Created by MAC on 24/10/20.
//  Copyright © 2020 Monish M S. All rights reserved.
//

import UIKit

class ActivityDetailsBadgeTableViewCell: UITableViewCell {
    @IBOutlet weak var lblComments: UILabel!
    
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var badgeIMage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
