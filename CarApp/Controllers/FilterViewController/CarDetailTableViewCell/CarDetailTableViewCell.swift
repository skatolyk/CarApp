//
//  CarDetailTableViewCell.swift
//  CarApp
//
//  Created by Seweryn Katolyk on 12/23/17.
//  Copyright © 2017 Seweryn Katolyk. All rights reserved.
//

import UIKit

class CarDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var carImageView: UIImageView!
    
    @IBOutlet weak var carNameLabel: UILabel!
    @IBOutlet weak var carTypeLabel: UILabel!
    @IBOutlet weak var doorsNumberLabel: UILabel!
    @IBOutlet weak var seatsNumberLabel: UILabel!
    @IBOutlet weak var conditioningLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var model: CarModel? {
        didSet {
            self.carImageView.image = model?.carImage()
            
            self.carNameLabel.text = model?.carName
            self.carTypeLabel.text = model?.carTypeString()
            self.doorsNumberLabel.text = model?.doorsString()
            self.seatsNumberLabel.text = model?.seatsString()
            self.conditioningLabel.text = model?.conditioningString()
            self.distanceLabel.text = model?.distanceString()
            self.priceLabel.text = model?.priceString()
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
