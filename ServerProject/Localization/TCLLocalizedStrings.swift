//
// Created by Артём Нешко on 20/04/2020.
//

import Foundation
import Localize_Swift

enum TCLLocalizedStrings: String {
    enum AppLanguage: String {
        case en = "en"
        case ru = "ru"
        
        var identifier: String {
            return rawValue
        }
        
        var name: String {
            switch self {
            case .en: return "ENG"
            case .ru: return "RU"
            }
        }
        
        var locale: String {
            switch self {
            case .en: return "en_US"
            case .ru: return "ru_RU"
            }
        }
        
        var dateTitleFormat: String {
            switch self {
            case .en: return "MMMM d"
            case .ru: return "d MMMM"
            }
        }
    }
    
    case password = "password"
    case badEmail = "bad_email"
    case schedule = "schedule"
    case today = "today"
    case yesterday = "yesterday"
    case tomorrow = "tomorrow"
    case logout = "logout"
    case lostTourist = "lost_tourist"
    case noEventsAvailable = "no_events_available"
    case place = "place"
    case touristsTotal = "tourists_total"
    case excursionIsFinished = "excursion_is_finished"
    case information = "information"
    case show = "show"
    case more = "more"
    case inProgress = "in_progress"
    case description = "description"
    case startBroadcasting = "start_broadcasting"
    case stopBroadcasting = "stop_broadcasting"
    case continueBroadcasting = "continue_broadcasting"
    case done = "done"
    case tourists = "tourists"
    case lostTouristConnection = "lost_tourist_connection"
    case whatToDo = "what_to_do"
    case finishExcursion = "finish_excursion"
    case question = "question"
    case questions = "questions"
    case finishExcursionTitle = "finish_excursion_title"
    case finishExcursionDescription = "finish_excursion_description"
    case yes = "yes"
    case headsetOffLabel = "headset_off_label"
    case headsetOffSubLabel = "headset_off_sub_label"
    case headsetOffСontinue = "headset_off_continue"
    case button = "button"
    case hallsNear = "hallsNear"
    case speker = "speker"
    case translation = "translation"
    case passInfo = "pass_info"
    case enterPassword = "enter_password"
    case badPasword = "bad_pasword"
    case speakers = "speakers"
    case availableTranslation = "available_translation"
    case expected = "expected"
    case showAll = "show_all"
    case noSpeakers = "no_speakers"
    case noName = "no_name"
    case hide = "hide"
    case okey = "okey"
    case plugHeadset = "plug_headset"
// NEW
    case january = "january"
    case february = "february"
    case march = "march"
    case april = "april"
    case may = "may"
    case june = "june"
    case july = "july"
    case august = "august"
    case september = "september"
    case october = "october"
    case november = "november"
    case december = "december"
    
    
    case monday = "monday"
    case tuesday = "tuesday"
    case wednesday = "wednesday"
    case thursday = "thursday"
    case friday = "friday"
    case saturday = "saturday"
    case sunday = "sunday"
    case months = "months"
    case currentValue = "all_values"
    case staticValue = "static_value"
    case highLoad = "highLoad"
    case lowLoad = "lowLoad"
    case normalLoad = "normalLoad"
//    case button = "button"
//    case button = "button"
//    case button = "button"
    
    var localized: String {
        return rawValue.localized()
    }
    
    static var currentLanguage: AppLanguage {
        return AppLanguage(rawValue: Localize.currentLanguage()) ?? .ru
    }
}


// Public
extension TCLLocalizedStrings {
    static func setLanguage(to language: AppLanguage) {
        Localize.setCurrentLanguage(language.identifier)
    }
}
