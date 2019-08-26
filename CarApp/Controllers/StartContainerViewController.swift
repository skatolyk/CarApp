//
//  StartContainerViewController.swift
//  CarApp
//
//  Created by Seweryn Katolyk on 12/21/17.
//  Copyright © 2017 Seweryn Katolyk. All rights reserved.
//

import UIKit
import SnapKit

final class StartContainerViewController: UIViewController {

    @IBOutlet private weak var changeLocationView: UIView!
    @IBOutlet private weak var dateView: UIView!
    @IBOutlet private weak var datePickerView: UIView!
    @IBOutlet private weak var roundedView: UIView!
    @IBOutlet private weak var roundedViewBootomConstraint: NSLayoutConstraint!
    @IBOutlet private weak var containerView: UIView!
    
    @IBOutlet private weak var leftDateView: UIView!
    @IBOutlet private weak var rightDateView: UIView!
    
    @IBOutlet private weak var leftDateLabel: UILabel!
    @IBOutlet private weak var rightDateLabel: UILabel!
    
    private let leftDateViewController = DateTimeViewController(nibName: DateTimeViewController.identifier,
                                                                bundle: nil)
    private let rightDateViewController = DateTimeViewController(nibName: DateTimeViewController.identifier,
                                                                 bundle: nil)
    private var activeViewController: UIViewController?
    
    private var mainCoordinator: CarFilterCoordinator = CarFilterCoordinator(presenter: UINavigationController())
    
    var popDatePicker: PopDatePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureGestures()
        configureDatePicker(leftDateViewController,
                                 in: leftDateView, dependedLabel: leftDateLabel)
        configureDatePicker(rightDateViewController,
                                 in: rightDateView, dependedLabel: rightDateLabel)
        rightDateViewController.date = Calendar.current.date(byAdding: .day, value: 1, to: Date())
        
        configureMainCoordinator()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureRoundedView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let mainNavigationController = segue.destination as? UINavigationController {
            activeViewController = mainNavigationController
        }
    }
    
    private func configureMainCoordinator() {
        mainCoordinator.delegate = self
        mainCoordinator.start()
        
        let presenter = mainCoordinator.presenter
        presenter.isNavigationBarHidden = true
        addChildViewController(presenter)
        
        containerView.addSubview(presenter.view)
        
        presenter.view.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalToSuperview()
        }
    }
    
    private func configureDatePicker(_ dateViewController: DateTimeViewController,
                                     `in` view: UIView, dependedLabel: UILabel) {
        dateViewController.delegate = self
        dateViewController.dependenceLabel = dependedLabel
        
        addChildViewController(dateViewController)
        view.addSubview(dateViewController.view)
        
        dateViewController.view.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalToSuperview()
        }
    }
    
    private func configureGestures() {
        let menuStackViewGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                    action: #selector(roundedViewAnimation))
        roundedView.addGestureRecognizer(menuStackViewGestureRecognizer)
        
        let changeLocationViewGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                         action: #selector(changeLocationTapped))
        changeLocationView.addGestureRecognizer(changeLocationViewGestureRecognizer)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(roundedViewAnimation))
        swipeUp.direction = UISwipeGestureRecognizerDirection.up
        view.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(roundedViewAnimation))
        swipeDown.direction = UISwipeGestureRecognizerDirection.down
        view.addGestureRecognizer(swipeDown)
    }
    
    func configureRoundedView() {
        let gradient = CAGradientLayer()
        gradient.frame.size = roundedView.frame.size
        
        gradient.colors = [UIColor(displayP3Red: 31/255, green: 134/255, blue: 211/255, alpha: 1).cgColor,
                           UIColor(displayP3Red: 19/255, green: 106/255, blue: 173/255, alpha: 1).cgColor]
        roundedView.layer.insertSublayer(gradient, at: 0)
        
        roundedView.addTopRoundedEdge(desiredCurve: 1.1)
    }

    @objc private func roundedViewAnimation() {
        if roundedViewBootomConstraint.constant == 0 {
            hideView(datePickerView, showView: dateView)
            roundedViewBootomConstraint.constant -= roundedView.frame.size.height * 2 / 3
        } else {
            hideView(dateView, showView: datePickerView)
           roundedViewBootomConstraint.constant = 0
        }
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.view.layoutIfNeeded()
        }
    }
    
    @objc private func changeLocationTapped() {
        present(UIAlertController.functionallityError(), animated: true, completion: nil)
    }
    
    private func hideView(_ hideView: UIView, showView: UIView) {
        UIView.animate(withDuration: 0.3, animations: {
            hideView.alpha = 0
        }) { success in
            showView.alpha = 1
            hideView.isHidden = true
            showView.isHidden = false
        }
    }

    @IBAction private func findCarsButtonPressed(_ sender: Any) {
        roundedViewAnimation()
        mainCoordinator.findCars()
    }
}

// MARK: - CarFilterCoordinatorDelegate
extension StartContainerViewController: CarFilterCoordinatorDelegate {
    func choosedCar(_ carModel: CarModel) {
        
        let carDetailViewController: CarDetailViewController = CarDetailViewController.instantiateViewController()
        carDetailViewController.model = carModel
        navigationController?.show(carDetailViewController, sender: self)
    }
    
    func menuChoosed(component: String) {
        let menuTabViewController = MenuTabViewController.instantiateViewController()
        navigationController?.show(menuTabViewController, sender: self)
        menuTabViewController.title = component
    }
}

// MARK: - DateTimeViewControllerDelegate
extension StartContainerViewController: DateTimeViewControllerDelegate {
    func dateTimePressed(_ sender: DateTimeViewController) {
        popDatePicker = PopDatePicker(for: sender.view.superview!)
        
        popDatePicker?.pick(self, initDate: sender.date) { (date, sourceView) in
            sender.date = date
        }
    }
}

