//
//  tabBarVC.swift
//  RegistrationApp
//
//  Created by Ziad on 3/18/20.
//  Copyright © 2020 intake4. All rights reserved.
//

import UIKit

class TabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabBar()
    }
    
    func setUpTabBar() {
        
        let mediaVC = UIStoryboard(name: Storyboards.main, bundle: nil).instantiateViewController(withIdentifier: VCs.MediaListVC) as! MediaListVC
        let mediaNav = UINavigationController(rootViewController: mediaVC)
        let moviesIcon = UITabBarItem(title: "Media", image: UIImage(named: "media"), selectedImage: UIImage(named: "media2"))
        mediaVC.tabBarItem = moviesIcon
        let profileVC = UIStoryboard(name: Storyboards.main, bundle: nil).instantiateViewController(withIdentifier: VCs.profileVC) as! ProfileVC
        let profileNav = UINavigationController(rootViewController: profileVC)
        let profileIcon = UITabBarItem(title: "Profile", image: UIImage(named: "profile1"), selectedImage: UIImage(named: "profile2"))
        profileVC.tabBarItem = profileIcon
        let controllers = [mediaNav, profileNav]
        self.viewControllers = controllers
        tabBar.backgroundColor = .white
    }

}
