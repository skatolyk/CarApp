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

final class DateTimeViewController: UIViewController {

    @IBOutlet private weak var dateDayLabel: UILabel!
    @IBOutlet private weak var weekDayLabel: UILabel!
    @IBOutlet private weak var monthLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    
    var date: Date? {
        didSet {
            let choosedDate = date ?? Date()
            
            dateDayLabel.text = choosedDate.day
            weekDayLabel.text = choosedDate.weekDay
            monthLabel.text = choosedDate.month
            timeLabel.text = choosedDate.time
            
            dependenceLabel?.text = choosedDate.fullDate
        }
    }
    
    var popDatePicker: PopDatePicker?
    var dependenceLabel: UILabel?
    
    weak var delegate: DateTimeViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        date = Date()
        
        let dateGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dateAreaTapped))
        view.addGestureRecognizer(dateGestureRecognizer)
    }

    @objc private func dateAreaTapped() {
        delegate?.dateTimePressed(self)
    }
}
