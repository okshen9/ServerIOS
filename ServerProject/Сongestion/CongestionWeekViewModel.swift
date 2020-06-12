//
//  ViewModel.swift
//  ServerProject
//
//  Created by Artem Neshko on 5/24/20.
//  Copyright © 2020 Artem Neshko. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources
import RxCocoa

class CongestionWeekViewModel {
    
    
    
    let db = DisposeBag()
    
    var sections = BehaviorRelay<[SectionModel]>(value: [.activitySection(items: [.activityItem])])
    
    //private
    var month: Month?
    var halls: [Day]?
    var nameMonth = BehaviorRelay(value: "Название месяца")
    
    init(_ month: Month) {
        halls = month.days
        sections.accept(self.generateSectionsFrom(month.days))
        nameMonth.accept(month.name )
    }
    
    
    func languageChanged() {
        guard self.halls != nil else { return }
        sections.accept(self.generateLoadingSections())
        
        print("rrr")
    }
    
    func getData(showActivityIndicator: Bool = true, completed: @escaping () -> ()) {
        if showActivityIndicator {
            sections.accept(self.generateLoadingSections())
            //            sections.value = self.generateLoadingSections()
        }
        
        //        NetworkService.provider.rx
        //            .request(.halls)
        //            .filterSuccessfulStatusCodes()
        //            .map([Hall].self, atKeyPath: "response", failsOnEmptyData: false)
        //            .subscribe(onSuccess: { [weak self] halls in
        //
        //                self?.sections.accept(self?.generateSectionsFrom(halls) ?? [])
        ////                self?.sections.value = self?.generateSectionsFrom(halls) ?? []
        //                completed()
        //
        //            }, onError: { error in
        //
        //                    print(error)
        //
        //                    completed()
        //            })
        //            .disposed(by: db)
        var days:[Day] = []
        for number in 1...7 {
            days.append(Day(index: number))
        }
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { timer in
            self.sections.accept(self.generateSectionsFrom(days))
            completed()
        }
    }
    
    private func generateSectionsFrom(_ halls: [Day]) -> [SectionModel] {
        self.halls = halls
        var sections: [SectionModel] = []
        guard !halls.isEmpty else {
            return [SectionModel]()
        }

        sections.append(SectionModel.chartsSection(items: [ItemModel.chartItem(monthes: self.halls ?? [])]))
        sections.append(SectionModel.hallsNearSection(items: [ItemModel.hallsNearItem(ident: TCLLocalizedStrings.currentLanguage.identifier)]))
        
        for hall in halls {
            sections.append(SectionModel.hallSection(items: [ItemModel.hallItem(hall: hall, persent: hall.persent, ident: hall.name )]))
        }
        
        return sections
    }
    
    
    private func generateLoadingSections() -> [SectionModel] {
        return [
            .hallsNearSection(items: [.hallsNearItem(ident: TCLLocalizedStrings.currentLanguage.identifier)]),
            .activitySection(items: [.activityItem])
        ]
    }
    
    private func generateBaseSections() -> [SectionModel] {
        
        
        return [
            .hallsNearSection(items: [.hallsNearItem(ident: TCLLocalizedStrings.currentLanguage.identifier)]),
            .activitySection(items: [.activityItem])
        ]
    }
    
    enum SectionModel: AnimatableSectionModelType {
        
        case chartsSection(items: [Item])
        case hallsNearSection(items: [Item])
        case hallSection(items: [Item])
        case activitySection(items: [Item])
        
        typealias Item = ItemModel
        typealias Identity = String
        
        var items: [Item] {
            switch self {
            case .chartsSection(items: let items): return items.map { $0 }
            case .hallsNearSection(items: let items): return items.map { $0 }
            case .hallSection(items: let items): return items.map { $0 }
            case .activitySection(items: let items): return items.map { $0 }
            }
        }
        
        init(original: SectionModel, items: [Item]) {
            switch original {
            case .hallsNearSection: self = .hallsNearSection(items: items)
            case .hallSection: self = .hallSection(items: items)
            case .activitySection: self = .activitySection(items: items)
            case .chartsSection: self = .chartsSection(items: items)
            }
        }
        
        var identity: Identity {
            switch self {
            case .hallsNearSection: return "hallsNearSection"
            case .hallSection: return "hallSection"
            case .activitySection: return "activitySection"
            case .chartsSection: return "chartsSection"
            }
        }
    }
    
    enum ItemModel: Equatable, IdentifiableType {
        case hallsNearItem(ident: String)
        case hallItem(hall: Day, persent: Int, ident: String)
        case activityItem
        case chartItem(monthes: [Day])
        
        typealias Identity = String
        
        static func ==(lhs: ItemModel, rhs: ItemModel) -> Bool {
            return lhs.identity == rhs.identity
        }
        
        var identity: Identity {
            switch self {
            case let .hallsNearItem(ident): return "hallsNearItem \(ident)"
            case let .hallItem(hall, persent, ident): return "hallItem \(hall.name) \(persent) \(ident)"
            case .activityItem: return "activityItem"
            case let .chartItem(monthes): return "chartItem\(monthes)"
            }
        }
    }
    
}

