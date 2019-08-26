//
//  MenuTableViewCell.swift
//  CarApp
//
//  Created by Seweryn Katolyk on 12/20/17.
//  Copyright © 2017 Seweryn Katolyk. All rights reserved.
//

import UIKit

final class MenuTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var menuImageView: UIImageView!
    @IBOutlet private weak var label: UILabel!
    
    var model: MenuCellModel? {
        didSet {
            label.text = model?.label
            menuImageView.image = model?.image
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            menuImageView.image = model?.activeImage
            label.textColor = UIColor(displayP3Red: 70/255, green: 136/255, blue: 241/255, alpha: 1)
        } else {
            menuImageView.image = model?.image
            label.textColor = UIColor(displayP3Red: 33/255, green: 33/255, blue: 33/255, alpha: 1)
        }
    }

}
