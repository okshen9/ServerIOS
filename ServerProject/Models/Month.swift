//
//  Month.swift
//  ServerProject
//
//  Created by Artem Neshko on 5/24/20.
//  Copyright © 2020 Artem Neshko. All rights reserved.
//

import Foundation
class Month: Entity {
    var number: Int
    var persent: Int
    var days: [Day] = []
    
    var name: String {
        switch number {
        case 1:
            return TCLLocalizedStrings.january.localized
        case 2:
            return TCLLocalizedStrings.february.localized
        case 3:
            return TCLLocalizedStrings.march.localized
        case 4:
            return TCLLocalizedStrings.april.localized
        case 5:
            return TCLLocalizedStrings.may.localized
        case 6:
            return TCLLocalizedStrings.june.localized
        case 7:
            return TCLLocalizedStrings.july.localized
        case 8:
            return TCLLocalizedStrings.august.localized
        case 9:
            return TCLLocalizedStrings.september.localized
        case 10:
            return TCLLocalizedStrings.october.localized
        case 11:
            return TCLLocalizedStrings.november.localized
        case 12:
            return TCLLocalizedStrings.december.localized
        default:
            return TCLLocalizedStrings.noName.localized
        }
    }
    
    init(index: Int, persent: Int = Int.random(in: 0...100)) {
        number = index
        self.persent = persent
    }
}

class Day: Entity {
    var number: Int = 0
    var persent: Int = 0
    
    var name: String {
        switch number {
        case 1: return TCLLocalizedStrings.monday.localized
        case 2: return TCLLocalizedStrings.tuesday.localized
        case 3: return TCLLocalizedStrings.wednesday.localized
        case 4: return TCLLocalizedStrings.thursday.localized
        case 5: return TCLLocalizedStrings.friday.localized
        case 6: return TCLLocalizedStrings.saturday.localized
        case 7: return TCLLocalizedStrings.sunday.localized
        default:
            return TCLLocalizedStrings.noName.localized
        }
    }
    
    init(index: Int, persent: Int = Int.random(in: 0...100)) {
        number = index
        self.persent = persent
    }
}


protocol Entity {
    var number: Int { get set }
    var name: String { get }
    var persent: Int { get set}
}
