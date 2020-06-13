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
    var days: [Day] = []
    
    var persent: Int {
        var allPersent = 0.0
        for hour in self.days {
            allPersent += Double(hour.persent)
        }
        return Int(allPersent / Double(days.count))
    }
    var currentPersent: Int {
        var allPersent = 0.0
        for hour in self.days {
            allPersent += Double(hour.currentPersent)
        }
        return Int(allPersent / Double(days.count))
    }
    
    var countDay: Int {return _countsDay[number]}
    
    private let _countsDay = [0, 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    
    
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
    
    init(index: Int) {
        number = index
        for indexDay in 1...countDay + 1 {
            days.append(Day(index: indexDay))
        }
    }
    
}

class Day: Entity {
    var number: Int
    var hours = [Hour]()

    var persent: Int {
        var allPersent = 0.0
        for hour in self.hours {
            allPersent += Double(hour.persent)
        }
        return Int(allPersent / Double(hours.count))
    }
    var currentPersent: Int {
        var allPersent = 0.0
        for hour in self.hours {
            allPersent += Double(hour.currentPersent)
        }
        return Int(allPersent / Double(hours.count))
    }
    var name: String {
        //        switch number {
        //        case 1: return TCLLocalizedStrings.monday.localized
        //        case 2: return TCLLocalizedStrings.tuesday.localized
        //        case 3: return TCLLocalizedStrings.wednesday.localized
        //        case 4: return TCLLocalizedStrings.thursday.localized
        //        case 5: return TCLLocalizedStrings.friday.localized
        //        case 6: return TCLLocalizedStrings.saturday.localized
        //        case 7: return TCLLocalizedStrings.sunday.localized
        //        default:
        //            return TCLLocalizedStrings.noName.localized
        //        }
        return "\(number)"
    }
    
    init(index: Int) {
        number = index
        for index in 0...24 {
            hours.append(Hour(index: index))
        }
    }
    
}

class Hour: Entity {
    var number: Int
    var name: String {
        return " \(number):00 "
    }
    var persent: Int
    var currentPersent: Int
    
    init(index: Int) {
        self.number = index
        self.persent = Int.random(in: 0...100)
        self.currentPersent = persent + Int.random(in: 30...30)
    }
}


protocol Entity {
    var number: Int { get set }
    var name: String { get }
    var persent: Int { get }
    var currentPersent: Int { get }
}
