//
//  String+Extention.swift
//  ServerProject
//
//  Created by Artem Neshko on 28.05.2020.
//  Copyright © 2020 Artem Neshko. All rights reserved.
//

import Foundation

extension String {
    static func getLoadStr(per: Int) -> String {
        if per > 70 {
            return TCLLocalizedStrings.highLoad.localized
        } else {
            if per > 40 {
                return TCLLocalizedStrings.normalLoad.localized
            } else {
                return TCLLocalizedStrings.lowLoad.localized
            }
        }
    }
}

extension StringProtocol {
    var firstUppercased: String { return prefix(1).uppercased() + dropFirst() }
    var firstCapitalized: String { return prefix(1).capitalized + dropFirst() }
}
