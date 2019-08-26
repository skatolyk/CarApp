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

final class CarFilterCoordinator: Coordinator {

    weak var delegate: CarFilterCoordinatorDelegate?
    
    let presenter: UINavigationController
    let mainViewController: MainViewController
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
        mainViewController = MainViewController.instantiateViewController()
        mainViewController.delegate = self
    }
    
    func start() {
        SideMenuConfiguration.menuController?.delegate = self
        presenter.setViewControllers([mainViewController], animated: true)
    }
    
    func findCars() {
        if let childCarViewController = presenter.topViewController as? ChildCarFilterViewController {
            childCarViewController.findCars()
        }
    }
    
}

// MARK: - MainViewControllerDelegate
extension CarFilterCoordinator: MainViewControllerDelegate {
    func segue(to viewController: FilterViewController) {
        viewController.delegate = self
    }
}

// MARK: - FilterViewControllerDelegate
extension CarFilterCoordinator: FilterViewControllerDelegate {
    func choosedCar(_ carModel: CarModel) {
        delegate?.choosedCar(carModel)
    }
}

// MARK: - MenuViewControllerDelegate
extension CarFilterCoordinator: MenuViewControllerDelegate {
    func menuChoosed(component: String) {
        delegate?.menuChoosed(component: component)
    }
}
