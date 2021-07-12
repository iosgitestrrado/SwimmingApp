//
//  ActivityListingDetailsVC.swift
//  SwimmingApp
//
//  Created by Monish M S on 20/09/19.
//  Copyright © 2019 Monish M S. All rights reserved.
//

import Foundation
import UIKit
class ActivityListingDetailsVC:UIViewController,SelectedChildDetailsDelegate{
   
    
    @IBOutlet var header: CommonHeader!
    @IBOutlet var menuBarView: MenuTabsView!
    
//    var tabs = ["Course1","Course2","Course3","Course4","Course5"]
    
    var tabs = ["Course1","Course2"]

    var pageController: UIPageViewController!
    var currentIndex: Int = 0
    var selectedIndex:Int = 0
    var sSelectedActivityId = ""
    var bSubmittedActivities = Bool()
    
    let color = UIColor(red: 53.0/255.0, green: 152.0/255.0, blue: 219.0/255.0, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupMenuBar()
        self.pageController.delegate = self
        self.pageController.dataSource = self
        self.menuBarView.menuDelegate = self
    }
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        menuBarView.collView.selectItem(at: IndexPath.init(item: selectedIndex, section: 0), animated: true, scrollPosition: .centeredVertically)
        
        pageController.setViewControllers([viewController(At: selectedIndex)!], direction: .forward, animated: true, completion: nil)
        
        view.layoutIfNeeded()
        
        menuBarView.collView.scrollToItem(at: IndexPath.init(item: selectedIndex, section: 0), at: .centeredHorizontally, animated: true)
        
    }
    func sendSelectedChildDFetailsD(sProfileName: String, sProfileImageName: String, sProfileEmail: String, sProfileMobNumber: String, iSelectedchldId: Int)
    {
        
        setupUI()
        setupMenuBar()
        self.pageController.delegate = self
        self.pageController.dataSource = self
        self.menuBarView.menuDelegate = self
        menuBarView.collView.selectItem(at: IndexPath.init(item: selectedIndex, section: 0), animated: true, scrollPosition: .centeredVertically)
        
        pageController.setViewControllers([viewController(At: selectedIndex)!], direction: .forward, animated: true, completion: nil)
        
        view.layoutIfNeeded()
        
        menuBarView.collView.scrollToItem(at: IndexPath.init(item: selectedIndex, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    func setupUI()
    {
        self.navigationController?.navigationBar.isHidden = true
        header.locationLabel.text = "Activity"
        header.profileNameLabel.text = (UserDefaults.standard.value(forKey: "name") as! String)
        header.imgProfile.sd_setImage(with: URL(string: (UserDefaults.standard.value(forKey: "imgUrl") as! String)), placeholderImage: UIImage(named: "person"))
        header.btnChildPopUp.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)

        header.backButtonHeight.constant = 0
        header.backButtonWidth.constant = 0
    }
    
    func setupMenuBar()
    {
        menuBarView.dataArray = UserDefaults.standard.value(forKey: "CourseArray") as! [String]
        menuBarView.isSizeToFitCellsNeeded = true
        menuBarView.collView.backgroundColor = color
        self.presentPageVCOnView()
    }
    @objc func buttonAction(sender: UIButton)
    {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let popupVC = storyBoard.instantiateViewController(withIdentifier: "ChildPopUpViewController") as! ChildPopUpViewController
        popupVC.SelectedChildDetailsDelegate = self

        self.addChild(popupVC)
        self.view.addSubview(popupVC.view)
        popupVC.didMove(toParent: self)

    }
    func presentPageVCOnView()
    {
        self.pageController = storyboard?.instantiateViewController(withIdentifier: "ActivityListingDetailsPageViewController") as! ActivityListingDetailsPageViewController
        self.pageController.view.frame = CGRect.init(x: 0, y: menuBarView.frame.maxY + 1 , width: self.view.frame.width, height: self.view.frame.height-(menuBarView.frame.maxY))
        self.addChild(self.pageController)
        self.view.addSubview(self.pageController.view)
        self.pageController.didMove(toParent: self)
        
    }
    
    func viewController(At index: Int) -> UIViewController?
    {
        if((self.menuBarView.dataArray.count == 0) || (index >= self.menuBarView.dataArray.count))
        {
            return nil
        }
        let contentVC = storyboard?.instantiateViewController(withIdentifier: "ActivityListingDetailsContentVC") as! ActivityListingDetailsContentVC
        //        contentVC.strTitle = tabs[index]
        contentVC.pageIndex = index
        contentVC.sSelectedActivityId = sSelectedActivityId
        
        contentVC.bSubmittedActivities = bSubmittedActivities
        print("page index==\(index)")
        //        contentVC.isFromJobNavigationControllerVC = true
        //        contentVC.selectedDate = selectedDate
        //        contentVC.menuBarView = menuBarView
        //        contentVC.isFutureDate = isFutureDate
        //        contentVC.delegate = self
        currentIndex = index
        return contentVC
    }
}


extension ActivityListingDetailsVC: MenuBarDelegate {
    
    func menuBarDidSelectItemAt(menu: MenuTabsView, index: Int) {
        userDefaults.SET_USERDEFAULTS(user_language: "ActivityIndex", objectValue: String(index))
        self.navigationController?.popViewController(animated: false)
        // If selected Index is other than Selected one, by comparing with current index, page controller goes either forward or backward.
        print("tabIndex=====\(index)")
        print("currentIndex====\(currentIndex)")
        if index != currentIndex {
            
            if index > currentIndex
            {
                print("FWD")
                
                self.pageController.setViewControllers([viewController(At: index)!], direction: .forward, animated: false, completion: nil)
            }
            else
            {
                print("BWD")
                
                self.pageController.setViewControllers([viewController(At: index)!], direction: .reverse, animated: false, completion: nil)
            }
            
            menuBarView.collView.scrollToItem(at: IndexPath.init(item: index, section: 0), at: .centeredHorizontally, animated: true)
            
            
        }
        else{
            
            self.pageController.setViewControllers([viewController(At: index)!], direction: .forward, animated: false, completion: nil)
            menuBarView.collView.scrollToItem(at: IndexPath.init(item: index, section: 0), at: .centeredHorizontally, animated: true)
        }
        
    }
    
}

extension ActivityListingDetailsVC: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        // print("AAAAAAAA")
        var index = (viewController as! ActivityListingDetailsContentVC).pageIndex
        print("ApageIndex\(index)")
        
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        
        index -= 1
        print("Aindex\(index)")
        return self.viewController(At: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        //print("BBBBBBBB")
        var index = (viewController as! ActivityListingDetailsContentVC).pageIndex
        print("BpageIndex\(index)")
        
        if (index == tabs.count) || (index == NSNotFound) {
            return nil
        }
        
        index += 1
        print("Bindex\(index)")
        return self.viewController(At: index)
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if finished {
            if completed {
                
                
                let cvc = pageViewController.viewControllers!.first as! ActivityListingDetailsContentVC
                let newIndex = cvc.pageIndex
                userDefaults.SET_USERDEFAULTS(user_language: "ActivityIndex", objectValue: String(newIndex))
                self.navigationController?.popViewController(animated: false)
                print("ActivityDetailsNextpageIndex :::::::\(newIndex)")
                menuBarView.collView.selectItem(at: IndexPath.init(item: newIndex, section: 0), animated: true, scrollPosition: .centeredVertically)
                menuBarView.collView.scrollToItem(at: IndexPath.init(item: newIndex, section: 0), at: .centeredHorizontally, animated: true)
            }
        }
        
    }
    
}

