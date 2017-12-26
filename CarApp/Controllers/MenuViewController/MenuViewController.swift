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

class MenuViewController: UIViewController {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate: MenuViewControllerDelegate?
    
    private var dataSource: [MenuCellModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.dataSource = [MenuCellModel(label: "History", imageName: "history"),
                      MenuCellModel(label: "Current orders", imageName: "current_orders"),
                      MenuCellModel(label: "Promos", imageName: "promos"),
                      MenuCellModel(label: "Payments", imageName: "payments"),
                      MenuCellModel(label: "Forums", imageName: "forums"),
                      MenuCellModel(label: "Updates", imageName: "updates"),
                      MenuCellModel(label: "Purchases", imageName: "purchases")]
        
        self.tableView.register(cell: MenuTableViewCell.self)
        self.userImage.roundBorderView()
    }

}

extension MenuViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MenuTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        
        cell.model = self.dataSource[indexPath.row]
        
        return cell
    }
}

extension MenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let choosedModel = self.dataSource[indexPath.row]
        
        self.dismiss(animated: true) {
            self.delegate?.menuChoosed(component: choosedModel.label)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
