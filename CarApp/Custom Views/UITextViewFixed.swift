//
//  UITextViewFixed.swift
//  CarApp
//
//  Created by Seweryn Katolyk on 12/22/17.
//  Copyright © 2017 Seweryn Katolyk. All rights reserved.
//

import UIKit

@IBDesignable class UITextViewFixed: UITextView {
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    func setup() {
        textContainerInset = .zero
        textContainer.lineFragmentPadding = 0
    }
}
