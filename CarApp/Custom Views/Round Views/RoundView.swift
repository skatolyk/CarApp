//
//  RoundView.swift
//  CarApp
//
//  Created by Seweryn Katolyk on 12/21/17.
//  Copyright © 2017 Seweryn Katolyk. All rights reserved.
//

import UIKit

@IBDesignable class RoundView: UIView {
    @IBInspectable var isRoundView: Bool = false {
        didSet {
            roundView(isRoundView)
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        roundView(isRoundView)
    }
}
