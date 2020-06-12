//
//  CusstomButton.swift
//
//  Created by Artem Neshko on 13/03/2019.
//

import UIKit

@IBDesignable
class CustomButton: UIButton {
    
    @IBInspectable var CornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = CornerRadius
        }
    }
    
}
