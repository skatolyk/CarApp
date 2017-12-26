//
//  BaseNavigationViewController.swift
//  CarApp
//
//  Created by Seweryn Katolyk on 12/22/17.
//  Copyright © 2017 Seweryn Katolyk. All rights reserved.
//

import UIKit

class BaseNavigationViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}
