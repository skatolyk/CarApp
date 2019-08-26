//
//  MenuTabViewController.swift
//  CarApp
//
//  Created by Seweryn Katolyk on 12/22/17.
//  Copyright © 2017 Seweryn Katolyk. All rights reserved.
//

import UIKit

final class MenuTabViewController: BaseNavigationViewController {
    
    @IBOutlet private weak var centralLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = title
        centralLabel.text = title
    }

}
