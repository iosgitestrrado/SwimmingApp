//
//  ActivityDetailsBottomTableViewCell.swift
//  SwimmingApp
//
//  Created by Monish M S on 20/09/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

import Foundation
import UIKit
class ActivityDetailsBottomTableViewCell:UITableViewCell{
    
    @IBOutlet var acivityListingCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet var activityListingCollectionView: UICollectionView!
}
extension ActivityDetailsBottomTableViewCell: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActivityDetailsBottomCollectionViewCell", for: indexPath) as! ActivityDetailsBottomCollectionViewCell
        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let val = collectionView.bounds.width/3.5
        return CGSize(width: val, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
