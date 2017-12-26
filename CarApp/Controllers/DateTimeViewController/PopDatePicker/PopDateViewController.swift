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
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    weak var delegate: DatePickerViewControllerDelegate?

    var currentDate: Date? {
        didSet {
            self.updatePickerCurrentDate()
        }
    }

    convenience init() {
        self.init(nibName: PopDateViewController.identifier, bundle: nil)
    }
    
    override func viewDidLoad() {
        self.datePicker.datePickerMode = .dateAndTime
        self.datePicker.minimumDate = Date()
        updatePickerCurrentDate()
    }
    
    private func updatePickerCurrentDate() {
        self.datePicker?.date = self.currentDate ?? Date()
    }
    
    @IBAction func okAction(_ sender: AnyObject) {
        self.delegate?.datePickerChoosed(self.datePicker.date)
        self.dismiss(animated: true, completion: nil)
    }
}
