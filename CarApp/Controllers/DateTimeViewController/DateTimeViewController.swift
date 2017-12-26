//
//  DateTimeViewController.swift
//  CarApp
//
//  Created by Seweryn Katolyk on 12/21/17.
//  Copyright © 2017 Seweryn Katolyk. All rights reserved.
//

import UIKit

protocol DateTimeViewControllerDelegate: class {
    func dateTimePressed(_ sender: DateTimeViewController)
}

class DateTimeViewController: UIViewController {

    @IBOutlet weak var dateDayLabel: UILabel!
    @IBOutlet weak var weekDayLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var date: Date? {
        didSet {
            let choosedDate = self.date ?? Date()
            
            self.dateDayLabel.text = choosedDate.day
            self.weekDayLabel.text = choosedDate.weekDay
            self.monthLabel.text = choosedDate.month
            self.timeLabel.text = choosedDate.time
            
            self.dependenceLabel?.text = choosedDate.fullDate
        }
    }
    
    var popDatePicker: PopDatePicker?
    var dependenceLabel: UILabel?
    
    weak var delegate: DateTimeViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.date = Date()
        
        let dateGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dateAreaTapped))
        self.view.addGestureRecognizer(dateGestureRecognizer)
    }

    @objc private func dateAreaTapped() {
        self.delegate?.dateTimePressed(self)
    }
}
