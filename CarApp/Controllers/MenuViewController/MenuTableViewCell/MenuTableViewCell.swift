//
//  MenuTableViewCell.swift
//  CarApp
//
//  Created by Seweryn Katolyk on 12/20/17.
//  Copyright © 2017 Seweryn Katolyk. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
    
    @IBOutlet weak var menuImageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    var model: MenuCellModel? {
        didSet {
            self.label.text = model?.label
            self.menuImageView.image = model?.image
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            self.menuImageView.image = model?.activeImage
            self.label.textColor = UIColor(displayP3Red: 70/255, green: 136/255, blue: 241/255, alpha: 1)
        } else {
            self.menuImageView.image = model?.image
            self.label.textColor = UIColor(displayP3Red: 33/255, green: 33/255, blue: 33/255, alpha: 1)
        }
    }

}
