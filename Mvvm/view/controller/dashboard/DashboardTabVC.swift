//
//  DashboardTabVC.swift
//  Mvvm
//
//  Created by laluheri on 9/20/20.
//  Copyright © 2020 hazard. All rights reserved.
//

import UIKit

class DashboardTabVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Dashboard"
        
        self.tabBar.items?[0].title = "Raw Material"
        self.tabBar.items?[1].title = "Profile"
    
    }
    
   
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.setHidesBackButton(true, animated: false)
    }

}
