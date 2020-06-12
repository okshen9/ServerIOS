//
//  CustomImageView.swift
//
//  Created by Artem Neshko on 05/07/2019.
//

import Foundation
import UIKit

@IBDesignable
class CustomImageView: UIImageView {
    
    @IBInspectable var CornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = CornerRadius
        }
    }
    
}
