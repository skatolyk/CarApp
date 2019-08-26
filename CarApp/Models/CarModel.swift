//
//  CarModel.swift
//  CarApp
//
//  Created by Seweryn Katolyk on 12/23/17.
//  Copyright © 2017 Seweryn Katolyk. All rights reserved.
//

import UIKit

enum CarType: String {
    case automatic = "Automatic"
    case mechanic = "Mechanic"
}

struct CarModel {
    private let carImageName: String
    let carName: String
    private let carType: CarType
    private let doorsNumber: Int
    private let seatsNumber: Int
    private let conditioning: String
    private let distance: Int
    private let price: Double
    let company: String
    let overview: String
    
    init(carImageName: String, carName: String, carType: CarType,
         doorsNumber: Int, seatsNumber: Int, conditioning: String,
         distance: Int, price: Double, company: String, overview: String) {
        
        self.carImageName   = carImageName
        self.carName        = carName
        self.carType        = carType
        self.doorsNumber    = doorsNumber
        self.seatsNumber    = seatsNumber
        self.conditioning   = conditioning
        self.distance       = distance
        self.price          = price
        self.company        = company
        self.overview       = overview
    }
    
    func carImage() -> UIImage {
        return UIImage(named: carImageName) ?? UIImage()
    }
    
    func carTypeString() -> String {
        return carType.rawValue
    }
    
    func doorsString() -> String {
        return "\(doorsNumber) Doors"
    }
    
    func seatsString() -> String {
        return "\(seatsNumber) Seats"
    }
    
    func conditioningString() -> String {
        return "\(conditioning) conditioning"
    }
    
    func distanceString() -> String {
        return "\(distance) km."
    }
    
    func priceString() -> String {
        return "€ \(price)/day"
    }
    
    func contains(doors: Int) -> Bool {
        return doorsNumber == doors
    }
    
    func contains(seats: Int) -> Bool {
        return seatsNumber == seats
    }
    
    func distance(more distance: Int) -> Bool {
        return distance < distance
    }
}
