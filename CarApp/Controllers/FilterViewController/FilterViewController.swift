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

class FilterViewController: BaseNavigationViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var seatsButton: UIButton!
    @IBOutlet weak var distanceButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var searchViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableViewTopConstraint: NSLayoutConstraint!
    
    weak var delegate: FilterViewControllerDelegate?
    
    private var allCars: [CarModel] = []
    private var dataSource: [CarModel] = []
    private var numberPicker: NumberPicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.allCars = self.hardcodeModels()
        self.dataSource = self.allCars
        
        self.tableView.register(cell: CarDetailTableViewCell.self)
        self.tableView.tableFooterView = UIView()
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
            self.tableViewTopConstraint.constant += searchViewHeightConstraint.constant
        } else {
//            self.seatsButton.setTitle("Seats: All", for: .normal)
//            self.distanceButton.setTitle("Distance: All", for: .normal)
//            self.nameTextField.text = ""
            self.tableViewTopConstraint.constant = 0
        }
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func setSeatsButtonTitle(_ seats: Int?) {
        let str = seats != nil ? seats.pureDesc : "All"
        self.seatsButton.setTitle("Seats: \(str)", for: .normal)
    }
    
    private func setDistanceButtonTitle(_ distance: Int?) {
        let str = distance != nil ? distance.pureDesc : "All"
        self.distanceButton.setTitle("Distance: \(str)", for: .normal)
    }
    
    private func number(from button: UIButton) -> Int? {
        if let numberString = button.titleLabel?.text?.components(separatedBy: CharacterSet.decimalDigits.inverted).joined() {
            return Int(numberString)
        }
        return nil
    }
    
    @IBAction func magnifyGlasButtonPressed(_ sender: Any) {
        self.refreshSearchView()
    }
    
    @IBAction func distanceButtonPressed(_ sender: UIButton) {
        self.numberPicker = NumberPicker(for: sender, with: hardcodeDistance())
        
        self.numberPicker?.pick(self,
                                initNumber: number(from: self.distanceButton),
                                title: "km") { [unowned self] (distance) in
            self.setDistanceButtonTitle(distance)
        }
    }
    
    @IBAction func seatsButtonPressed(_ sender: UIButton) {
        self.numberPicker = NumberPicker(for: sender, with: hardcodeSeats())
        
        self.numberPicker?.pick(self,
                                initNumber: number(from: self.seatsButton),
                                title: "seats") { [unowned self] (seats) in
            self.setSeatsButtonTitle(seats)
        }
    }
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        self.dataSource = self.allCars.filter { [unowned self] in
            if let number = number(from: self.distanceButton), $0.distance(more: number) {
                return false
            }
            
            if let number = number(from: self.seatsButton), $0.contains(seats: number) == false {
                return false
            }
            
            if let carName = self.nameTextField?.text?.lowercased(), carName.isEmpty == false {
                return $0.carName.lowercased().contains(carName)
            }
            return true
        }
        self.refreshSearchView()
        self.tableView.reloadData()
    }
    
}

extension FilterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CarDetailTableViewCell = tableView.dequeueReusableCell(for: indexPath)

        cell.model = self.dataSource[indexPath.row]
        cell.contentView.backgroundColor = indexPath.row % 2 == 1 ? .cellLightGray : .white
        
        return cell
    }
}

extension FilterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.choosedCar(self.dataSource[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension FilterViewController: ChildCarFilterViewController {
    func findCars() {
        self.present(UIAlertController.functionallityError(), animated: true, completion: nil)
    }
}
