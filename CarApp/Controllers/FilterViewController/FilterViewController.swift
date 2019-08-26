//
//  FilterViewController.swift
//  CarApp
//
//  Created by Seweryn Katolyk on 12/21/17.
//  Copyright © 2017 Seweryn Katolyk. All rights reserved.
//

import UIKit

protocol FilterViewControllerDelegate: class {
    func choosedCar(_ carModel: CarModel)
}

final class FilterViewController: BaseNavigationViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var seatsButton: UIButton!
    @IBOutlet private weak var distanceButton: UIButton!
    @IBOutlet private weak var nameTextField: UITextField!
    
    @IBOutlet private weak var searchViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var tableViewTopConstraint: NSLayoutConstraint!
    
    weak var delegate: FilterViewControllerDelegate?
    
    private var allCars: [CarModel] = []
    private var dataSource: [CarModel] = []
    private var numberPicker: NumberPicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allCars = hardcodeModels()
        dataSource = allCars
        
        tableView.register(cell: CarDetailTableViewCell.self)
        tableView.tableFooterView = UIView()
    }
    
    private func hardcodeModels() -> [CarModel] { // TODO: Hardcode!! Remove it!
        return [CarModel(carImageName: "bmw_series_5", carName: "BMW series 5", carType: .automatic, doorsNumber: 4, seatsNumber: 5, conditioning: "Air", distance: 4, price: 7.50, company: "Avis", overview: "BMW series 5"),
                           CarModel(carImageName: "bmw", carName: "BMW", carType: .mechanic, doorsNumber: 4, seatsNumber: 5, conditioning: "Air", distance: 4, price: 3.50, company: "Avis", overview: "BMW"),
                           CarModel(carImageName: "mercedes_benz_s63", carName: "Mercedes Benz S63", carType: .automatic, doorsNumber: 4, seatsNumber: 5, conditioning: "Air", distance: 4, price: 6.50, company: "Avis", overview: "Mercedes Benz S63"),
                           CarModel(carImageName: "mercedes_cls", carName: "Mercedes CLS", carType: .automatic, doorsNumber: 4, seatsNumber: 5, conditioning: "Air", distance: 4, price: 9.50, company: "Avis", overview: "Mercedes CLS")]
    }
    
    private func hardcodeSeats() -> [Int] { // TODO: Hardcode!! Remove it!
        return [2, 3, 4, 5, 7]
    }
    
    private func hardcodeDistance() -> [Int] { // TODO: Hardcode!! Remove it!
        return Array(1...100)
    }
    
    private func refreshSearchView() {
        if tableViewTopConstraint.constant == 0 {
            tableViewTopConstraint.constant += searchViewHeightConstraint.constant
        } else {
//            seatsButton.setTitle("Seats: All", for: .normal)
//            distanceButton.setTitle("Distance: All", for: .normal)
//            nameTextField.text = ""
            tableViewTopConstraint.constant = 0
        }
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.view.layoutIfNeeded()
        }
    }
    
    private func setSeatsButtonTitle(_ seats: Int?) {
        let str = seats != nil ? seats.pureDesc : "All"
        seatsButton.setTitle("Seats: \(str)", for: .normal)
    }
    
    private func setDistanceButtonTitle(_ distance: Int?) {
        let str = distance != nil ? distance.pureDesc : "All"
        distanceButton.setTitle("Distance: \(str)", for: .normal)
    }
    
    private func number(from button: UIButton) -> Int? {
        if let numberString = button.titleLabel?.text?.components(separatedBy: CharacterSet.decimalDigits.inverted).joined() {
            return Int(numberString)
        }
        return nil
    }
    
    @IBAction private func magnifyGlasButtonPressed(_ sender: Any) {
        refreshSearchView()
    }
    
    @IBAction private func distanceButtonPressed(_ sender: UIButton) {
        numberPicker = NumberPicker(for: sender, with: hardcodeDistance())
        
        numberPicker?.pick(self,
                           initNumber: number(from: distanceButton),
                           title: "km") { [weak self] (distance) in
            self?.setDistanceButtonTitle(distance)
        }
    }
    
    @IBAction private func seatsButtonPressed(_ sender: UIButton) {
        numberPicker = NumberPicker(for: sender, with: hardcodeSeats())
        
        numberPicker?.pick(self,
                           initNumber: number(from: seatsButton),
                           title: "seats") { [weak self] (seats) in
            self?.setSeatsButtonTitle(seats)
        }
    }
    
    @IBAction private func searchButtonPressed(_ sender: Any) {
        dataSource = allCars.filter { [weak self] in
            if let number = self?.number(from: distanceButton), $0.distance(more: number) {
                return false
            }
            
            if let number = self?.number(from: seatsButton), $0.contains(seats: number) == false {
                return false
            }
            
            if let carName = self?.nameTextField?.text?.lowercased(), carName.isEmpty == false {
                return $0.carName.lowercased().contains(carName)
            }
            return true
        }
        refreshSearchView()
        tableView.reloadData()
    }
    
}

// MARK: - IBActions
extension FilterViewController {
    
}

// MARK: - UITableViewDataSource
extension FilterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CarDetailTableViewCell = tableView.dequeueReusableCell(for: indexPath)

        cell.model = dataSource[indexPath.row]
        cell.contentView.backgroundColor = indexPath.row % 2 == 1 ? .cellLightGray : .white
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension FilterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.choosedCar(dataSource[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - ChildCarFilterViewController
extension FilterViewController: ChildCarFilterViewController {
    func findCars() {
        present(UIAlertController.functionallityError(), animated: true, completion: nil)
    }
}
