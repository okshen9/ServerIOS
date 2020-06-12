//
//  CustomView.swift
//
//  Created by Artem Neshko on 23.03.2018.
//

import UIKit

@IBDesignable
class CustomView: UIView {

  @IBInspectable var CornerRadius: CGFloat = 0.0 {
    didSet {
      self.layer.cornerRadius = CornerRadius
    }
  }

  @IBInspectable var BorderColor: UIColor? {
    didSet {
      self.layer.borderColor = BorderColor?.cgColor
    }
  }

  @IBInspectable var BorderWidth: CGFloat = 0.0 {
    didSet {
      self.layer.borderWidth = BorderWidth
    }
  }

  @IBInspectable var ShadowColor: UIColor = .clear {
    didSet {
      self.layer.shadowColor = ShadowColor.cgColor
    }
  }

  @IBInspectable var ShadowOpacity: Float = 0.0 {
    didSet {
      self.layer.shadowOpacity = ShadowOpacity
    }
  }

  @IBInspectable var ShadowOffset: CGSize = CGSize(width: 0.0, height: 0.0) {
    didSet {
      self.layer.shadowOffset = ShadowOffset
    }
  }

  @IBInspectable var ShadowRadius: CGFloat = 0.0 {
    didSet {
      self.layer.shadowRadius = ShadowRadius / 2.0
    }
  }

  @IBInspectable var ShadowSpread: CGFloat = 0.0 {
    didSet {
      if ShadowSpread == 0 {
        self.layer.shadowPath = nil
      } else {
        let dx = -ShadowSpread
        let rect = bounds.insetBy(dx: dx, dy: dx)
        self.layer.shadowPath = UIBezierPath(rect: rect).cgPath
      }
    }
  }

}
