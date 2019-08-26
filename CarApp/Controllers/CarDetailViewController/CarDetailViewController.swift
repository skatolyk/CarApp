//
//  CarDetailViewController.swift
//  CarApp
//
//  Created by Seweryn Katolyk on 12/21/17.
//  Copyright © 2017 Seweryn Katolyk. All rights reserved.
//

import UIKit

final class CarDetailViewController: BaseNavigationViewController {

    @IBOutlet private weak var roundedView: UIView!
    @IBOutlet private weak var carImageView: UIImageView!
    
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var carTypeLabel: UILabel!
    @IBOutlet private weak var doorsNumberLabel: UILabel!
    @IBOutlet private weak var seatsNumberLabel: UILabel!
    @IBOutlet private weak var conditioningLabel: UILabel!
    @IBOutlet private weak var companyNameLabel: UILabel!
    
    @IBOutlet private weak var overviewLabel: UITextViewFixed!
    @IBOutlet private weak var bookButton: UIButton!
    
    var model: CarModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        carImageView.image = model?.carImage()
        
        titleLabel.text = model?.carName
        carTypeLabel.text = model?.carTypeString()
        doorsNumberLabel.text = model?.doorsString()
        seatsNumberLabel.text = model?.seatsString()
        conditioningLabel.text = model?.conditioningString()
        priceLabel.text = model?.priceString()
        companyNameLabel.text = model?.company
        overviewLabel.text = model?.overview
        
        bookButton.setTitle("BOOK WITH \(model?.company.uppercased() ?? "")", for: .normal)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        roundedView.addBottomRoundedEdge(desiredCurve: 2)
    }

    @IBAction private func bookButtonPressed(_ sender: Any) {
        present(UIAlertController.functionallityError(), animated: true, completion: nil)
    }
    
}
