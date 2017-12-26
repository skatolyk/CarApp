//
//  UIColor+Extensions.swift
//  CarApp
//
//  Created by Seweryn Katolyk on 12/26/17.
//  Copyright © 2017 Seweryn Katolyk. All rights reserved.
//

import Foundation
import UIKit.UIColor

extension UIColor {
    open class var cellLightGray: UIColor {
        get {
            return UIColor(displayP3Red: 239/255, green: 239/255, blue: 239/255, alpha: 1)
        }
    } // 0.5, 0.0, 0.5 RGB
}
