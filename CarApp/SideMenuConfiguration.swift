//
//  SideMenuConfiguration.swift
//  CarApp
//
//  Created by Seweryn Katolyk on 12/21/17.
//  Copyright © 2017 Seweryn Katolyk. All rights reserved.
//

import SideMenu

struct SideMenuConfiguration {

    static let sideMenuManager = SideMenuManager.default
    
    static func configure() {
        sideMenuManager.menuPresentMode = .menuSlideIn
        sideMenuManager.menuFadeStatusBar = false
        
        let appWindowRect = UIApplication.shared.keyWindow?.bounds ?? UIWindow().bounds
        
        sideMenuManager.menuWidth = appWindowRect.width/4 * 3
        
        let storyboard = UIStoryboard.main()
        
        sideMenuManager.menuLeftNavigationController = storyboard.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? UISideMenuNavigationController
    }
    
    static var menuController: MenuViewController? {
        return sideMenuManager.menuLeftNavigationController?.topViewController as? MenuViewController
    }

}
