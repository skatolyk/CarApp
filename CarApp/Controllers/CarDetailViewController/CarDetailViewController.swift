//
//  CarDetailViewController.swift
//  CarApp
//
//  Created by Seweryn Katolyk on 12/21/17.
//  Copyright © 2017 Seweryn Katolyk. All rights reserved.
//

import UIKit

class CarDetailViewController: BaseNavigationViewController {

    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var carImageView: UIImageView!
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var carTypeLabel: UILabel!
    @IBOutlet weak var doorsNumberLabel: UILabel!
    @IBOutlet weak var seatsNumberLabel: UILabel!
    @IBOutlet weak var conditioningLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    
    @IBOutlet weak var overviewLabel: UITextViewFixed!
    @IBOutlet weak var bookButton: UIButton!
    
    var model: CarModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.carImageView.image = model?.carImage()
        
        self.titleLabel.text = model?.carName
        self.carTypeLabel.text = model?.carTypeString()
        self.doorsNumberLabel.text = model?.doorsString()
        self.seatsNumberLabel.text = model?.seatsString()
        self.conditioningLabel.text = model?.conditioningString()
        self.priceLabel.text = model?.priceString()
        self.companyNameLabel.text = model?.company
        self.overviewLabel.text = model?.overview
        
        self.bookButton.setTitle("BOOK WITH \(model?.company.uppercased() ?? "")", for: .normal)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        roundedView.addBottomRoundedEdge(desiredCurve: 2)
    }

    @IBAction func bookButtonPressed(_ sender: Any) {
        self.present(UIAlertController.functionallityError(), animated: true, completion: nil)
    }
    
}
