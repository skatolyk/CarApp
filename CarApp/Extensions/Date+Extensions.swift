//
//  Date+Extensions.swift
//  CarApp
//
//  Created by Seweryn Katolyk on 12/26/17.
//  Copyright © 2017 Seweryn Katolyk. All rights reserved.
//

import Foundation

extension Date {
    
    var day: String {
        return String(Calendar.current.component(.day, from: self))
    }
    
    var weekDay: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        return dateFormatter.string(from: self)
    }
    
    var month: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM"
        return dateFormatter.string(from: self)
    }
    
    var time: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: self)
    }
    
    var fullDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM HH:mm"
        return dateFormatter.string(from: self)
    }
}

extension Optional {
    
    var pureDesc: String {
        if let unwrapped = self {
            return String(describing: unwrapped)
        }
        return ""
    }
}
