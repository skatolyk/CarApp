//
//  TableViewCell.swift
//  CarApp
//
//  Created by Seweryn Katolyk on 12/20/17.
//  Copyright © 2017 Seweryn Katolyk. All rights reserved.
//

import UIKit

extension UIView {
    
    func roundBorderView() {
        roundView()
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.white.cgColor
        
    }
    
    func roundView(_ round: Bool = true) {
        layer.masksToBounds = !round
        layer.cornerRadius = round ? frame.size.width / 2 : 0
        clipsToBounds = round
    }
    
    func addTopRoundedEdge(desiredCurve: CGFloat) {
        // Call this function in viewDidLayoutSubviews for correct work
        let offset = frame.width / desiredCurve
        let bounds = self.bounds
        
        let rectBounds = CGRect(x: bounds.origin.x,
                                y: bounds.origin.y + bounds.size.height / 2,
                                width: bounds.size.width,
                                height: bounds.size.height / 2)
        
        let rectPath = UIBezierPath(rect: rectBounds)
        let ovalBounds = CGRect(x: bounds.origin.x - offset / 2,
                                y: bounds.origin.y,
                                width: bounds.size.width + offset,
                                height: bounds.size.height)
        let ovalPath = UIBezierPath(ovalIn: ovalBounds)
        rectPath.append(ovalPath)
        
        // Create the shape layer and set its path
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = rectPath.cgPath
        
        // Set the newly created shape layer as the mask for the view's layer
        layer.mask = maskLayer
    }
    
    func addBottomRoundedEdge(desiredCurve: CGFloat) {
        // Call this function in viewDidLayoutSubviews for correct work
        let offset = frame.width / desiredCurve
        let bounds = self.bounds
        
        let rectBounds = CGRect(x: bounds.origin.x,
                                y: bounds.origin.y - bounds.size.height / 2,
                                width: bounds.size.width,
                                height: bounds.size.height)
        
        let rectPath = UIBezierPath(rect: rectBounds)
        let ovalBounds = CGRect(x: bounds.origin.x - offset / 2,
                                y: bounds.origin.y,
                                width: bounds.size.width + offset,
                                height: bounds.size.height)
        let ovalPath = UIBezierPath(ovalIn: ovalBounds)
        rectPath.append(ovalPath)
        
        // Create the shape layer and set its path
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = rectPath.cgPath
        
        // Set the newly created shape layer as the mask for the view's layer
        layer.mask = maskLayer
    }
}
