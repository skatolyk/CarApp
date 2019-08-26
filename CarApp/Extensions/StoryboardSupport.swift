//
//  StoryboardSupport.swift
//  CarApp
//
//  Created by Seweryn Katolyk on 12/20/17.
//  Copyright © 2017 Seweryn Katolyk. All rights reserved.
//

import UIKit

extension UIStoryboard {
    class func main() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
}

extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UIViewController {
    static var identifier: String {
        return String(describing: self)
    }
    
    static func instantiateViewController<T: UIViewController>(_ bundle: Bundle? = nil) -> T {
        let sb = UIStoryboard.main()
        return sb.instantiateViewController(withIdentifier: identifier) as! T
    }
}

extension UIView {
    static var className: String {
        let className = NSStringFromClass(self)
        guard let range = className.range(of: ".") else { return "" }
        return String(className[range.upperBound...])
    }
    
    class func nib() -> UINib {
        return UINib(nibName: className, bundle: Bundle(for: self))
    }
    
    class func viewFromNib() -> UIView {
        return nib().instantiate(withOwner: self, options: nil).first as? UIView ?? UIView()
    }
}

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError("Could not find table view cell with identifier \(T.identifier)")
        }
        return cell
    }
    
    func cellForRow<T: UITableViewCell>(at indexPath: IndexPath) -> T {
        guard let cell = cellForRow(at: indexPath) as? T else {
            fatalError("Could not get cell as type \(T.self)")
        }
        return cell
    }
    
    func register<T: UITableViewCell>(cell: T.Type) {
        register(T.nib(), forCellReuseIdentifier: T.identifier)
    }
}

/// Use in view controllers:
///
/// 1) Have view controller conform to SegueHandlerType
/// 2) Add `enum SegueIdentifier: String { }` to conformance
/// 3) Manual segues are trigged by `performSegue(with:sender:)`
/// 4) `prepare(for:sender:)` does a `switch segueIdentifier(for: segue)` to select the appropriate segue case

protocol SegueHandlerType {
    associatedtype SegueIdentifier: RawRepresentable
}

extension SegueHandlerType where Self: UIViewController, SegueIdentifier.RawValue == String {
    
    func performSegue(withIdentifier identifier: SegueIdentifier, sender: Any?) {
        performSegue(withIdentifier: identifier.rawValue, sender: sender)
    }
    
    func segueIdentifier(for segue: UIStoryboardSegue) -> SegueIdentifier {
        guard let identifier = segue.identifier,
            let segueIdentifier = SegueIdentifier(rawValue: identifier) else {
                fatalError("Invalid segue identifier: \(String(describing: segue.identifier))")
        }
        return segueIdentifier
    }
    
}

