//
//  MenuTabViewController.swift
//  CarApp
//
//  Created by Seweryn Katolyk on 12/22/17.
//  Copyright © 2017 Seweryn Katolyk. All rights reserved.
//

import UIKit

class MenuTabViewController: BaseNavigationViewController {
    
    @IBOutlet weak var centralLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleLabel.text = self.title
        self.centralLabel.text = self.title
    }

}
