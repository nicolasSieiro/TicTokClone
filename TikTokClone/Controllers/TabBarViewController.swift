//
//  TabBarViewController.swift
//  TikTokClone
//
//  Created by Nicolas Sieiro on 09/02/2021.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
        tabBar.isTranslucent = true
    }
    
    override func viewDidLoad() {
        print("hello")
    }
}
