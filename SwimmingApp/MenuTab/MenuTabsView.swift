//
//  MenuTabsView.swift
//  SwimmingApp
//
//  Created by Monish M S on 19/09/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

import Foundation
import UIKit

protocol MenuBarDelegate {
    func menuBarDidSelectItemAt(menu: MenuTabsView,index: Int)
}


class MenuTabsView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    lazy var collView: UICollectionView = {
        
        let layOut = UICollectionViewFlowLayout()
        let cv = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layOut)
        cv.showsHorizontalScrollIndicator = false
        layOut.scrollDirection = .horizontal
        cv.backgroundColor = .white
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    
    var isSizeToFitCellsNeeded: Bool = false {
        didSet{
            self.collView.reloadData()
        }
    }
    
    var menuSelectedArray = [Int: Bool]()
    
    var dataArray: [String] = [] {
        didSet{
            for index in 0 ..< dataArray.count{
                menuSelectedArray[index] = false
            }
            print("Data Array Count\(dataArray.count)")
            menuSelectedArray[0] = true
            self.collView.reloadData()
        }
    }
    
    
    var menuDidSelected: ((_ collectionView: UICollectionView, _ indexPath: IndexPath)->())?
    
    var menuDelegate: MenuBarDelegate?
    var cellId = "BasicCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        customIntializer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        customIntializer()
    }
    
    
    private func customIntializer () {
        
        collView.register(BasicCell.self, forCellWithReuseIdentifier: cellId)
        addSubview(collView)
        addConstraintsWithFormatString(formate: "V:|[v0]|", views: collView)
        addConstraintsWithFormatString(formate: "H:|[v0]|", views: collView)
        backgroundColor = .clear
        
    }
    
    
    //MARK: CollectionView Delegate Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? BasicCell {
            cell.titleLabel.text = dataArray[indexPath.item]
            cell.titleLabel.font = cell.titleLabel.font.withSize(13)
            //cell.titleLabel.font = UIFont(name: "Lato-Semibold", size: CGFloat(10))
            
            //            if menuSelectedArray[indexPath.row] == false{
            //                print("cellforrowat\(indexPath.row)")
            //               cell.titleLabel.textColor = UIColor.black
            //            }else{
            //               cell.titleLabel.textColor = UIColor(red: 176.0/255.0, green: 27.0/255.0, blue: 42.0/255.0, alpha: 1.0)
            //            }
            cell.titleLabel.textColor = UIColor.white
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        print("sizeForItemAt")
        if isSizeToFitCellsNeeded
        {
            
            let sizeee = CGSize.init(width: 200, height: self.frame.height)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            
            let str = dataArray[indexPath.item]
            
            let estimatedRect = NSString.init(string: str).boundingRect(with: sizeee, options: options, attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 23)], context: nil)
            
            return CGSize.init(width: estimatedRect.size.width, height: self.frame.height)
            
        }
        
        return CGSize.init(width: (self.frame.width - 10)/CGFloat(dataArray.count), height: self.frame.height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        
        //        let indexPath = IndexPath(row: indexPath.row, section: 0)
        //        let cell = collectionView.cellForItem(at: indexPath) as! BasicCell
        //
        //        print("menuSelectedArrayCount\(menuSelectedArray.count)")
        //        for pos in 0 ..< menuSelectedArray.count{
        //            if pos != indexPath.row{
        //                menuSelectedArray[pos] = false
        //                print("didSelectItemAtfalse.......\(pos)")
        //                cell.titleLabel.textColor = UIColor.black
        //            }else{
        //                menuSelectedArray[pos] = true
        //                print("didSelectItemAtTrue.......\(pos)")
        //                cell.titleLabel.textColor = UIColor(red: 176.0/255.0, green: 27.0/255.0, blue: 42.0/255.0, alpha: 1.0)
        //            }
        //        }
        //
        //        collectionView.reloadData()
        //        DispatchQueue.main.async(execute: {
        //            print("DispatchQueue completes")
        //            let index = Int(indexPath.item)
        //            self.menuDelegate?.menuBarDidSelectItemAt(menu: self, index: index)
        //        })
        
        let index = Int(indexPath.item)
        self.menuDelegate?.menuBarDidSelectItemAt(menu: self, index: index)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
    
    func scrollToItem(at indexPath: IndexPath, at scrollPosition: UICollectionView.ScrollPosition, animated: Bool){
        print("ScrollPosition")
    }
    
}
