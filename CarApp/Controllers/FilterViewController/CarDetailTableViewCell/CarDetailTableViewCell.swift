//
//  CarDetailTableViewCell.swift
//  CarApp
//
//  Created by Seweryn Katolyk on 12/23/17.
//  Copyright © 2017 Seweryn Katolyk. All rights reserved.
//

import UIKit

final class CarDetailTableViewCell: UITableViewCell {

    @IBOutlet private weak var carImageView: UIImageView!
    
    @IBOutlet private weak var carNameLabel: UILabel!
    @IBOutlet private weak var carTypeLabel: UILabel!
    @IBOutlet private weak var doorsNumberLabel: UILabel!
    @IBOutlet private weak var seatsNumberLabel: UILabel!
    @IBOutlet private weak var conditioningLabel: UILabel!
    @IBOutlet private weak var distanceLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    
    var model: CarModel? {
        didSet {
            carImageView.image = model?.carImage()
            
            carNameLabel.text = model?.carName
            carTypeLabel.text = model?.carTypeString()
            doorsNumberLabel.text = model?.doorsString()
            seatsNumberLabel.text = model?.seatsString()
            conditioningLabel.text = model?.conditioningString()
            distanceLabel.text = model?.distanceString()
            priceLabel.text = model?.priceString()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
