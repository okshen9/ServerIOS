//
//  Colors.swift
//  turfonSpeaker
//
//  Created by Артём Нешко on 20/04/2019.
//  Copyright © 2018 Dmitry Rogov. All rights reserved.
//

import UIKit

extension UIColor {
    
   static func colorGradint(number: Int) -> UIColor {
        let max      = 100
        
        let fromR  = 0
        let fromG  = 255
        let fromB  = 0
        
        let toR    = 255
        let toG    = 0
        let toB    = 0
        
        let deltaR = ((toR - fromR) / max)
        let deltaG = ((toG - fromG) / max)
        let deltaB = ((toB - fromB) / max)
        
        let red: CGFloat = CGFloat((fromR + number * deltaR)) / 255
        let green: CGFloat = CGFloat((fromG + number * deltaG)) / 255
        let blue: CGFloat = CGFloat((fromB + number * deltaB)) / 255
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
    
    static func mixGreenAndRed(greenAmount: Float, saturation: Float = 0.3) -> UIColor {
        // the hues between red and green go from 0…1/3, so we can just divide percentageGreen by 3 to mix between them
        return UIColor(hue: CGFloat(greenAmount / 360), saturation: 0.3, brightness: 1.0, alpha: 1.0)
    }
    
    convenience init(hexString: String) {
        var cString: String = hexString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }
        
        if (cString.count) != 6 {
            self.init(red: 255, green: 255, blue: 255, alpha: 1)
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    @nonobjc class var rouge: UIColor {
        return UIColor(red: 170.0 / 255.0, green: 30.0 / 255.0, blue: 35.0 / 255.0, alpha: 1.0)
    }
    

    @nonobjc class var blueGrey: UIColor {
        return UIColor(red: 248 / 255.0, green: 248 / 255.0, blue: 248 / 255.0, alpha: 0.0)
    }

    @nonobjc class var lightBlack: UIColor {
        return UIColor(red: 182.0/255.0, green: 182.0/255.0, blue: 182.0/255.0, alpha: 0.87)
    }
    
    @nonobjc class var botonLineColor: UIColor {
        return UIColor(red: 216.0/255.0, green: 216.0/255.0, blue: 216.0/255.0, alpha: 1.0)
    }
    
    @nonobjc class var black87: UIColor {
        return UIColor(red: 0, green: 0, blue: 0, alpha: 0.87)
    }
    
    @nonobjc class var black34: UIColor {
        return UIColor(red: 0, green: 0, blue: 0, alpha: 0.34)
    }
    
    @nonobjc class var white87: UIColor {
        return UIColor(red: 1, green: 1, blue: 1, alpha: 0.87)
    }
    
    @nonobjc class var redWhiteCircle: UIColor {
        return UIColor(red: 180.0/255.0, green: 72.0/255.0, blue: 72.0/255.0, alpha: 1.0)
    }
}
