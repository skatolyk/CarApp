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

class MainViewController: UIViewController {
    
    @IBOutlet weak var menuStackView: UIStackView!
    
    weak var delegate: MainViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let menuStackViewGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showMenu))
        
        self.menuStackView.addGestureRecognizer(menuStackViewGestureRecognizer)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(showMenu))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? FilterViewController {
            self.delegate?.segue(to: destinationVC)
        }
    }
    
    @objc private func showMenu() {
        if let leftMenu = SideMenuManager.default.menuLeftNavigationController {
            self.present(leftMenu, animated: true, completion: nil)
        }
    }
    
    @IBAction func userButtonPressed(_ sender: Any) {
        self.present(UIAlertController.functionallityError(), animated: true, completion: nil)
    }
}

extension MainViewController: ChildCarFilterViewController {
    func findCars() {
        self.performSegue(withIdentifier: "toFilterVC", sender: self)
    }
}
