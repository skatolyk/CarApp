//
//  StartContainerViewController.swift
//  CarApp
//
//  Created by Seweryn Katolyk on 12/21/17.
//  Copyright © 2017 Seweryn Katolyk. All rights reserved.
//

import UIKit
import SnapKit

class StartContainerViewController: UIViewController {

    @IBOutlet weak var changeLocationView: UIView!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var datePickerView: UIView!
    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var roundedViewBootomConstraint: NSLayoutConstraint!
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var leftDateView: UIView!
    @IBOutlet weak var rightDateView: UIView!
    
    @IBOutlet weak var leftDateLabel: UILabel!
    @IBOutlet weak var rightDateLabel: UILabel!
    
    private let leftDateViewController = DateTimeViewController(nibName: DateTimeViewController.identifier,
                                                                bundle: nil)
    private let rightDateViewController = DateTimeViewController(nibName: DateTimeViewController.identifier,
                                                                 bundle: nil)
    private var activeViewController: UIViewController?
    
    private var mainCoordinator: CarFilterCoordinator = CarFilterCoordinator(presenter: UINavigationController())
    
    var popDatePicker: PopDatePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureGestures()
        self.configureDatePicker(leftDateViewController,
                                 in: leftDateView, dependedLabel: leftDateLabel)
        self.configureDatePicker(rightDateViewController,
                                 in: rightDateView, dependedLabel: rightDateLabel)
        self.rightDateViewController.date = Calendar.current.date(byAdding: .day, value: 1, to: Date())
        
        self.configureMainCoordinator()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        roundedView.addTopRoundedEdge(desiredCurve: 1.1)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let mainNavigationController = segue.destination as? UINavigationController {
            self.activeViewController = mainNavigationController
        }
    }
    
    private func configureMainCoordinator() {
        mainCoordinator.delegate = self
        mainCoordinator.start()
        
        let presenter = mainCoordinator.presenter
        presenter.isNavigationBarHidden = true
        self.addChildViewController(presenter)
        
        self.containerView.addSubview(presenter.view)
        
        presenter.view.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalToSuperview()
        }
    }
    
    private func configureDatePicker(_ dateViewController: DateTimeViewController,
                                     `in` view: UIView, dependedLabel: UILabel) {
        dateViewController.delegate = self
        dateViewController.dependenceLabel = dependedLabel
        
        self.addChildViewController(dateViewController)
        view.addSubview(dateViewController.view)
        
        dateViewController.view.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalToSuperview()
        }
    }
    
    private func configureGestures() {
        let menuStackViewGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                    action: #selector(roundedViewAnimation))
        self.roundedView.addGestureRecognizer(menuStackViewGestureRecognizer)
        
        let changeLocationViewGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                         action: #selector(changeLocationTapped))
        self.changeLocationView.addGestureRecognizer(changeLocationViewGestureRecognizer)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(roundedViewAnimation))
        swipeUp.direction = UISwipeGestureRecognizerDirection.up
        self.view.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(roundedViewAnimation))
        swipeDown.direction = UISwipeGestureRecognizerDirection.down
        self.view.addGestureRecognizer(swipeDown)
    }
    
    @objc private func roundedViewAnimation() {
        if roundedViewBootomConstraint.constant == 0 {
            self.hideView(self.datePickerView, showView: self.dateView)
            roundedViewBootomConstraint.constant -= roundedView.frame.size.height * 2 / 3
        } else {
            self.hideView(self.dateView, showView: self.datePickerView)
           roundedViewBootomConstraint.constant = 0
        }
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func changeLocationTapped() {
        self.present(UIAlertController.functionallityError(), animated: true, completion: nil)
    }
    
    private func hideView(_ hideView: UIView, showView: UIView) {
        UIView.animate(withDuration: 0.3, animations: {
            hideView.alpha = 0
        }) { (success) in
            showView.alpha = 1
            hideView.isHidden = true
            showView.isHidden = false
        }
    }

    @IBAction func findCarsButtonPressed(_ sender: Any) {
        self.roundedViewAnimation()
        self.mainCoordinator.findCars()
    }
}

extension StartContainerViewController: CarFilterCoordinatorDelegate {
    func choosedCar(_ carModel: CarModel) {
        
        let carDetailViewController: CarDetailViewController = CarDetailViewController.instantiateViewController()
        carDetailViewController.model = carModel
        self.navigationController?.show(carDetailViewController, sender: self)
    }
    
    func menuChoosed(component: String) {
        let menuTabViewController = MenuTabViewController.instantiateViewController()
        self.navigationController?.show(menuTabViewController, sender: self)
        menuTabViewController.title = component
    }
}

extension StartContainerViewController: DateTimeViewControllerDelegate {
    
    
    func dateTimePressed(_ sender: DateTimeViewController) {
        self.popDatePicker = PopDatePicker(for: sender.view.superview!)
        
        popDatePicker?.pick(self, initDate: sender.date) { (date, sourceView) in
            sender.date = date
        }
    }
}

