//
//  UICollectionView+extension.swift
//
//  Created by Artem Neshko on 15/05/2019.
//

import Foundation
import UIKit

extension UICollectionView {
    
    func registerNibForCell<T>(_ class: T) {
        var className = String(describing: T.self)
        
        className = String(className.dropLast(5)) // dropping ".Type"
        let nib = UINib(nibName: className, bundle: nil)
        
        register(nib, forCellWithReuseIdentifier: className)
    }
    
    func dequeueReusableCell<T>(_ class: T, for: IndexPath) -> UICollectionViewCell {
        return dequeueReusableCell(withReuseIdentifier: String(String(describing: T.self).dropLast(5)), for: `for`)
    }
}


extension UITableView {
    
    func registerNibForCell<T>(_ class: T) {
        var className = String(describing: T.self)
        
        className = String(className.dropLast(5)) // dropping ".Type"
        let nib = UINib(nibName: className, bundle: nil)
    
        register(nib, forCellReuseIdentifier: className)
    }
    
    func dequeueReusableCell<T>(_ class: T, for: IndexPath) -> UITableViewCell {
        return dequeueReusableCell(withIdentifier: String(String(describing: T.self).dropLast(5)), for: `for`)
    }
}
