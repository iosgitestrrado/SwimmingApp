//
//  CommonHeader.swift
//  SwimmingApp
//
//  Created by Monish M S on 19/07/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

@IBDesignable class CommonHeader:UIView{
    
    var view:UIView!
    
    @IBOutlet weak var imhgDropDown: UIImageView!
    @IBOutlet weak var btnChildPopUp: UIButton!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var backButton: UIButton!
    @IBOutlet var backButtonHeight: NSLayoutConstraint!
    @IBOutlet var backButtonWidth: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imgProfile.layer.cornerRadius  = 20
        imgProfile.sd_setImage(with: URL(string: (UserDefaults.standard.value(forKey: "imgUrl") as! String)), placeholderImage: UIImage(named: "person"))

        
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    private func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "CommonHeader", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    private func xibSetup() {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        addSubview(view)
    }
    
    @IBAction func actionChildPopUp(_ sender: Any)
    {
        
      
        
    }
}
