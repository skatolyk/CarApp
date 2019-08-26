//
//  MainViewController.swift
//  CarApp
//
//  Created by Seweryn Katolyk on 12/20/17.
//  Copyright © 2017 Seweryn Katolyk. All rights reserved.
//

import SideMenu

protocol MainViewControllerDelegate: class {
    func segue(to viewController: FilterViewController)
}

final class MainViewController: UIViewController {
    
    @IBOutlet private weak var menuStackView: UIStackView!
    
    weak var delegate: MainViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let menuStackViewGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showMenu))
        
        menuStackView.addGestureRecognizer(menuStackViewGestureRecognizer)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(showMenu))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        view.addGestureRecognizer(swipeRight)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? FilterViewController {
            delegate?.segue(to: destinationVC)
        }
    }
    
    @objc private func showMenu() {
        if let leftMenu = SideMenuManager.default.menuLeftNavigationController {
            present(leftMenu, animated: true, completion: nil)
        }
    }
    
    @IBAction private func userButtonPressed(_ sender: Any) {
        present(UIAlertController.functionallityError(), animated: true, completion: nil)
    }
}

// MARK: - ChildCarFilterViewController
extension MainViewController: ChildCarFilterViewController {
    func findCars() {
        performSegue(withIdentifier: "toFilterVC", sender: self)
    }
}
