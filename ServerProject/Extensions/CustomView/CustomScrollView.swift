//
//  CustomScrollView.swift
//
//  Created by Artem Neshko on 16/08/2019.
//

import Foundation
import UIKit

class CustomCollectionView: UICollectionView {
    @IBInspectable var CornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = CornerRadius
        }
    }
}
