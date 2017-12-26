//
//  CarFilterCoordinator.swift
//  CarApp
//
//  Created by Seweryn Katolyk on 12/22/17.
//  Copyright © 2017 Seweryn Katolyk. All rights reserved.
//

import UIKit

protocol CarFilterCoordinatorDelegate: class {
    func choosedCar(_ carModel: CarModel)
    func menuChoosed(component: String)
}

class CarFilterCoordinator: Coordinator {

    weak var delegate: CarFilterCoordinatorDelegate?
    
    let presenter: UINavigationController
    let mainViewController: MainViewController
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
        self.mainViewController = MainViewController.instantiateViewController()
        self.mainViewController.delegate = self
    }
    
    func start() {
        SideMenuConfiguration.menuController()?.delegate = self
        self.presenter.setViewControllers([mainViewController], animated: true)
    }
    
    func findCars() {
        if let childCarViewController = self.presenter.topViewController as? ChildCarFilterViewController {
            childCarViewController.findCars()
        }
    }
    
}

extension CarFilterCoordinator: MainViewControllerDelegate {
    func segue(to viewController: FilterViewController) {
        viewController.delegate = self
    }
}

extension CarFilterCoordinator: FilterViewControllerDelegate {
    func choosedCar(_ carModel: CarModel) {
        self.delegate?.choosedCar(carModel)
    }
}

extension CarFilterCoordinator: MenuViewControllerDelegate {
    func menuChoosed(component: String) {
        self.delegate?.menuChoosed(component: component)
    }
}
