//
//  MenuViewController.swift
//  CarApp
//
//  Created by Seweryn Katolyk on 12/20/17.
//  Copyright © 2017 Seweryn Katolyk. All rights reserved.
//

import UIKit

protocol MenuViewControllerDelegate: class {
    func menuChoosed(component: String)
}

final class MenuViewController: UIViewController {

    @IBOutlet private weak var userImage: UIImageView!
    @IBOutlet private weak var tableView: UITableView!
    
    weak var delegate: MenuViewControllerDelegate?
    
    private var dataSource: [MenuCellModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        dataSource = [MenuCellModel(label: "History", imageName: "history"),
                      MenuCellModel(label: "Current orders", imageName: "current_orders"),
                      MenuCellModel(label: "Promos", imageName: "promos"),
                      MenuCellModel(label: "Payments", imageName: "payments"),
                      MenuCellModel(label: "Forums", imageName: "forums"),
                      MenuCellModel(label: "Updates", imageName: "updates"),
                      MenuCellModel(label: "Purchases", imageName: "purchases")]
        
        tableView.register(cell: MenuTableViewCell.self)
        userImage.roundBorderView()
    }

}

// MARK: - UITableViewDataSource
extension MenuViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MenuTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        
        cell.model = dataSource[indexPath.row]
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension MenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let choosedModel = dataSource[indexPath.row]
        
        dismiss(animated: true) { [weak self] in
            self?.delegate?.menuChoosed(component: choosedModel.label)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
