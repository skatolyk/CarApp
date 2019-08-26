//
//  NumberPicker.swift
//  CarApp
//
//  Created by Seweryn Katolyk on 12/26/17.
//  Copyright © 2017 Seweryn Katolyk. All rights reserved.
//

import UIKit

class NumberPicker: NSObject {
    public typealias NumberPickerCallback = (_ newNumber: Int?) -> ()
    
    private var numberPickerVC: NumberPickerViewController
    private var popover: UIPopoverPresentationController?
    private var sourceView: UIView
    private var numberChanged: NumberPickerCallback?
    var title: String?
    
    public init(for view: UIView, with elements: [Int]) {
        numberPickerVC = NumberPickerViewController()
        numberPickerVC.elements = elements
        sourceView = view
        super.init()
    }
    
    public func pick(_ inViewController: UIViewController,
                     initNumber: Int?, title: String?, numberChanged: @escaping NumberPickerCallback) {
        numberPickerVC.delegate = self
        numberPickerVC.modalPresentationStyle = .popover
        numberPickerVC.preferredContentSize = CGSize(width: 500, height: 208)
        numberPickerVC.initNumber = initNumber
        numberPickerVC.pickerTitle = title
        
        if let popover = numberPickerVC.popoverPresentationController {
            popover.permittedArrowDirections = .up
            popover.sourceView = sourceView
            popover.sourceRect = CGRect(x: sourceView.bounds.size.width / 2,
                                        y: sourceView.bounds.size.height,
                                        width: 0, height: 0)
            popover.delegate = self
            self.numberChanged = numberChanged
            inViewController.present(numberPickerVC, animated: true, completion: nil)
        }
    }
}

// MARK: - UIPopoverPresentationControllerDelegate
extension NumberPicker: UIPopoverPresentationControllerDelegate {
    public func adaptivePresentationStyle(for controller: UIPresentationController,
                                          traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
}

// MARK: - NumberPickerViewControllerDelegate
extension NumberPicker: NumberPickerViewControllerDelegate {
    func numberPickerCoose(_ number: Int?) {
        numberChanged?(number)
    }
}
