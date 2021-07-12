//
//  MileStoneActivityListingTableViewCellTwo.swift
//  SwimmingApp
//
//  Created by Monish M S on 27/09/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

import Foundation
import UIKit
class MileStoneActivityListingTableViewCellTwo:UITableViewCell{
    
    @IBOutlet var descriptionLabel: UILabel!
    
    @IBOutlet var activityCollectionView: UICollectionView!
    
    @IBOutlet var acivityListingCollectionViewHeight: NSLayoutConstraint!
    var mediaList = [MediaDataModel]()
}
extension MileStoneActivityListingTableViewCellTwo: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mediaList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MileStoneActivityMediaCollectionViewCellTwo", for: indexPath) as! MileStoneActivityMediaCollectionViewCellTwo
        cell.activityImage!.sd_setImage(with: URL(string: mediaList[indexPath.row].file!), placeholderImage: UIImage(named: "swim-child.png"))
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


