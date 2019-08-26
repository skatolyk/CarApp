//
//  PopDateViewController.swift
//  CarApp
//
//  Created by Seweryn Katolyk on 12/21/17.
//  Copyright © 2017 Seweryn Katolyk. All rights reserved.
//

import UIKit

protocol DatePickerViewControllerDelegate: class {
    func datePickerChoosed(_ date: Date?)
}

class PopDateViewController: UIViewController {
    
    @IBOutlet private weak var datePicker: UIDatePicker!
    
    weak var delegate: DatePickerViewControllerDelegate?

    var currentDate: Date? {
        didSet {
            updatePickerCurrentDate()
        }
    }

    convenience init() {
        self.init(nibName: PopDateViewController.identifier, bundle: nil)
    }
    
    override func viewDidLoad() {
        datePicker.datePickerMode = .dateAndTime
        datePicker.minimumDate = Date()
        updatePickerCurrentDate()
    }
    
    private func updatePickerCurrentDate() {
        datePicker?.date = currentDate ?? Date()
    }
    
    @IBAction private func okAction(_ sender: AnyObject) {
        delegate?.datePickerChoosed(datePicker.date)
        dismiss(animated: true, completion: nil)
    }
}
