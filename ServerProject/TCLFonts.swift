//
// Created by Артём Нешко on 20/04/2019.
// Copyright (c) 2018 Dmitry Rogov. All rights reserved.
//

import UIKit

enum TCLFonts: String {
    
    case timesNewRoman = "TimesNewRomanPSMT"
    case timesNewRomanItalic = "TimesNewRomanPS-ItalicMT"
    case timesNewRomanBold = "TimesNewRomanPS-BoldMT"
    
    func ofSize(_ size: CGFloat) -> UIFont {
        
        guard let font = UIFont(name: rawValue, size: size) else {
            
            return UIFont.systemFont(ofSize: size)
        }
        
        return font
    }
    
}
