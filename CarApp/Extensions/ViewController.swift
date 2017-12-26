//
//  ViewController.swift
//  CarApp
//
//  Created by Seweryn Katolyk on 12/22/17.
//  Copyright © 2017 Seweryn Katolyk. All rights reserved.
//

import UIKit

extension UIAlertController {
    class func functionallityError() -> UIAlertController {
        let alert = UIAlertController(title: "Error",
                                      message: "This functionallity will be implemented in future.",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return alert
    }
}
