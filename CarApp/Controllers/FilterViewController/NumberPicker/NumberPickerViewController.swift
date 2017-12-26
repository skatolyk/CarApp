//
//  NumberPickerViewController.swift
//  CarApp
//
//  Created by Seweryn Katolyk on 12/26/17.
//  Copyright © 2017 Seweryn Katolyk. All rights reserved.
//

import UIKit

protocol NumberPickerViewControllerDelegate: class {
    func numberPickerCoose(_ number: Int?)
}

class NumberPickerViewController: UIViewController {

    var elements: [Int] = []
    var pickerTitle: String?
    var initNumber: Int?
    
    weak var delegate: NumberPickerViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let picker = UIPickerView()
        picker.dataSource = self
        picker.delegate = self
        
        if let number = initNumber, let index = elements.index(of: number) {
            picker.selectRow(index + 1, inComponent: 0, animated: false)
        }
        self.view = picker
    }

}

extension NumberPickerViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        guard self.pickerTitle != nil else {
            return 1
        }
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return component == 0 ? self.elements.count + 1 : 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 1 {
            return self.pickerTitle
        } else {
            if row == 0 {
                return "All"
            } else {
                return String(self.elements[row - 1])
            }
        }
    }
}

extension NumberPickerViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row > 0 {
            self.delegate?.numberPickerCoose(self.elements[row - 1])
        } else {
            self.delegate?.numberPickerCoose(nil)
        }
    }
}
