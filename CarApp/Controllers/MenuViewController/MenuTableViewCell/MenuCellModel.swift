//
//  MenuCellModel.swift
//  CarApp
//
//  Created by Seweryn Katolyk on 12/21/17.
//  Copyright © 2017 Seweryn Katolyk. All rights reserved.
//

import Foundation
import UIKit.UIImage

struct MenuCellModel {
    
    let label: String
    private let imageName: String
    
    init(label: String, imageName: String) {
        self.label = label
        self.imageName = imageName
    }
    
    var image: UIImage {
        return UIImage(named: imageName) ?? UIImage()
    }
    
    var activeImage: UIImage {
        return UIImage(named: "active_\(imageName)") ?? UIImage()
    }
    
}
