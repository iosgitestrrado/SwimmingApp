//
//  UserChatTableViewCell.swift
//  SwimmingApp
//
//  Created by MAC on 17/10/20.
//  Copyright © 2020 Monish M S. All rights reserved.
//

import UIKit

class UserChatTableViewCell: UITableViewCell
{
    @IBOutlet weak var txtMessage: UITextView!
    
    @IBOutlet weak var lblUserdate: UILabel!
    
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblUserTime: UILabel!
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
