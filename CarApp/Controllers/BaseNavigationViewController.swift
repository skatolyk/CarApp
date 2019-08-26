//
//  BaseNavigationViewController.swift
//  CarApp
//
//  Created by Seweryn Katolyk on 12/22/17.
//  Copyright © 2017 Seweryn Katolyk. All rights reserved.
//

import UIKit

class BaseNavigationViewController: UIViewController {

    @IBOutlet internal weak var titleLabel: UILabel!
    
    @IBAction private func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
