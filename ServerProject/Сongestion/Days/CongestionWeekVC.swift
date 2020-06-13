//
//  CongestionWekkVC.swift
//  ServerProject
//
//  Created by Artem Neshko on 5/24/20.
//  Copyright © 2020 Artem Neshko. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxOptional
import RxDataSources

class CongestionWeekVC: TCLViewController {
    
    @IBOutlet weak var nameMonth: UILabel!
    @IBOutlet weak var ibCollectionView: UICollectionView! {
        didSet {
            ibCollectionView.registerNibForCell(HallsNearCell.self)
            ibCollectionView.registerNibForCell(MonthViewCell.self)
            ibCollectionView.registerNibForCell(ActivityIndicatorCell.self)
            ibCollectionView.registerNibForCell(ChartCell.self)
        }
    }
    
    typealias Section = CongestionWeekViewModel.SectionModel
    typealias Item = CongestionWeekViewModel.ItemModel
    
    var viewModel: CongestionWeekViewModel! = nil
    var dataSource: RxCollectionViewSectionedAnimatedDataSource<Section>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addLanguageButtons()
        self.prepare()
        self.subscribe()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        label.text = "Server monitor"
        label.font = UIFont(name: "SnellRoundhand", size: 21)
        self.navigationItem.titleView = label
    }
    
    private func prepare() {
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.done, target: nil, action: nil)
        
        dataSource = generateDataSource()
        
        ibCollectionView.rx
            .setDelegate(self)
            .disposed(by: db)
    }
    
    private func subscribe() {
        
        self.viewModel.nameMonth.asObservable().subscribe(onNext: { [unowned self] name in
            if self.nameMonth != nil {
                self.nameMonth.text = name.firstUppercased
            }
        }).disposed(by: db)
        self.viewModel.sections.asObservable()
            .bind(to: self.ibCollectionView.rx.items(dataSource: dataSource))
            .disposed(by: db)
        
        self.ibCollectionView.rx.itemSelected
            .subscribe(onNext: { [unowned self] indexPath in
                let item: Item = self.dataSource[indexPath]
                
                switch item {
                case .hallItem(hall: let hall, _, _):
                    
                    //                    if hall.password != nil {
                    //                        Router.password(hall: hall).push(from: self.navigationController)
                    //                    } else {
                    //                        Router.room(hall: hall).push(from: self.navigationController)
                    //                    }
                    print("click \(hall.name)")
                    
                default: break
                    
                }
            })
            .disposed(by: db)
        viewModel.getData {}
    }
    
    private func generateDataSource() -> RxCollectionViewSectionedAnimatedDataSource<Section> {
        return RxCollectionViewSectionedAnimatedDataSource<Section>(
            animationConfiguration: AnimationConfiguration(insertAnimation: .fade, reloadAnimation: .fade, deleteAnimation: .top),
            configureCell: { dataSource, collectionView, indexPath, item in
                switch item {
                case .chartItem(monthes: let monthes):
                    let cell = collectionView.dequeueReusableCell(ChartCell.self, for: indexPath) as! ChartCell
                    cell.setup(valuePersent: monthes)
                    return cell
                case .hallsNearItem(_):
                    let cell = collectionView.dequeueReusableCell(HallsNearCell.self, for: indexPath) as! HallsNearCell
                    cell.ibHallsNearLabel.text = TCLLocalizedStrings.hallsNear.localized
                    return cell
                    
                case .hallItem(hall: let hall, _, _):
                    let cell = collectionView.dequeueReusableCell(MonthViewCell.self, for: indexPath) as! MonthViewCell
                    cell.setup(name: hall.name, persent: hall.persent)
                    return cell
                    
                case .activityItem:
                    let cell = collectionView.dequeueReusableCell(ActivityIndicatorCell.self, for: indexPath) as! ActivityIndicatorCell
                    return cell
                }
                
        },
            configureSupplementaryView: { _, _, _, _ in
                return UICollectionReusableView()
        })
    }
    
    
    //MARK: - Language
    override func ruLanguageSelected() {
        
        super.ruLanguageSelected()
        self.ibCollectionView.reloadData()
        
        //        viewModel.languageChanged()
    }
    
    override func enLanguageSelected() {
        
        super.enLanguageSelected()
        self.ibCollectionView.reloadData()
        //        viewModel.languageChanged()
    }
}

extension CongestionWeekVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let item: Item = dataSource[indexPath]
        let width: CGFloat = 375
        
        switch item {
        case .chartItem:
            return CGSize(width: width, height: 300)
        case .hallsNearItem(ident: _):
            let height = HallsNearCell.calculateHeight(width: width)
            return CGSize(width: width, height: height)
        case .hallItem(hall: let hall, persent: let persent, ident: _):
            let height = MonthViewCell.calculateHeight(for: hall.name, per: persent, width: width)
            return CGSize(width: width, height: height)
        case .activityItem:
            return CGSize(width: width, height: 60)
        }
    }
    
}
