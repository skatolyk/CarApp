//
//  PopDatePicker.swift
//  CarApp
//
//  Created by Seweryn Katolyk on 12/21/17.
//  Copyright © 2017 Seweryn Katolyk. All rights reserved.
//

import UIKit

public class PopDatePicker: NSObject {
    
    public typealias PopDatePickerCallback = (_ newDate: Date?, _ sourceView: UIView) -> ()
    
    private var datePickerVC: PopDateViewController
    private var popover: UIPopoverPresentationController?
    private var sourceView: UIView
    private var dataChanged: PopDatePickerCallback?
    
    public init(for view: UIView) {
        datePickerVC = PopDateViewController()
        sourceView = view
        super.init()
    }
    
    public func pick(_ inViewController: UIViewController,
                     initDate: Date?, dataChanged: @escaping PopDatePickerCallback) {
        
        datePickerVC.delegate = self
        datePickerVC.modalPresentationStyle = .popover
        datePickerVC.preferredContentSize = CGSize(width: 500, height: 208)
        datePickerVC.currentDate = initDate
        
        if let popover = datePickerVC.popoverPresentationController {
            popover.permittedArrowDirections = .down
            popover.sourceView = sourceView
            popover.sourceRect = CGRect(x: sourceView.bounds.size.width / 2,
                                        y: sourceView.bounds.origin.y,
                                        width: 0, height: 0)
            popover.delegate = self
            self.dataChanged = dataChanged
            inViewController.present(datePickerVC, animated: true, completion: nil)
        }
    }
}

// MARK: - UIPopoverPresentationControllerDelegate
extension PopDatePicker: UIPopoverPresentationControllerDelegate {
    public func adaptivePresentationStyle(for controller: UIPresentationController,
                                          traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
}

// MARK: - DatePickerViewControllerDelegate
extension PopDatePicker: DatePickerViewControllerDelegate {
    func datePickerChoosed(_ date: Date?) {
        dataChanged?(date, sourceView)
    }
}
