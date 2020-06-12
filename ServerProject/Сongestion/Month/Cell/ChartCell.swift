//
//  ChartCell.swift
//  ServerProject
//
//  Created by Artem Neshko on 28.05.2020.
//  Copyright © 2020 Artem Neshko. All rights reserved.
//

import UIKit
import Charts

class ChartCell: UICollectionViewCell {
    
    var currentValue: [Int] =  [1, 2, 5, 8, 9, 7, 7]
    var staticValue: [Int] = [1, 2, 5, 8, 9, 7, 7]
    var nameX: [String] = ["1", "2", "3", "4", "5", "6", "7"]
    
    @IBOutlet weak var chartView: CombinedChartView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        chartView.delegate = self
        chartView.scaleXEnabled = true
        chartView.scaleYEnabled = false
        chartView.maxVisibleCount = currentValue.count
        // Initialization code
    }
    
    func setup(valuePersent: [Entity]) {
        currentValue = []
        
        var dataEntries: [BarChartDataEntry] = []
        var colors = [UIColor]()
        for i in 0..<valuePersent.count {
            let dataEntry = BarChartDataEntry(x: Double(i + 1), y: Double(valuePersent[i].persent))
            colors.append(UIColor.mixGreenAndRed(greenAmount: Float(valuePersent[i].persent), saturation: 0.7))
            dataEntries.append(dataEntry)
            currentValue.append((valuePersent[i].persent))
        }
        var monthsName = [String]()
        for month in valuePersent {
            monthsName.append(month.name)
        }
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: TCLLocalizedStrings.allValues.localized)
        chartDataSet.colors = colors
        let data = CombinedChartData()
        data.barData = BarChartData(dataSet: chartDataSet)
        data.lineData = generateLineData()
        
        chartView.data = data
        
    }
    
    
    
    func generateLineData() -> LineChartData {
        let entries = (0..<currentValue.count).map { (i) -> ChartDataEntry in
            return ChartDataEntry(x: Double(i) + 0.5, y: Double(arc4random_uniform(15) + 5))
        }
    
        let set = LineChartDataSet(entries: entries, label: "Line DataSet")
        set.setColor(UIColor(red: 240/255, green: 238/255, blue: 70/255, alpha: 1))
        set.lineWidth = 2.5
        set.setCircleColor(UIColor(red: 240/255, green: 238/255, blue: 70/255, alpha: 1))
        set.circleRadius = 5
        set.circleHoleRadius = 2.5
        set.fillColor = UIColor(red: 240/255, green: 238/255, blue: 70/255, alpha: 1)
        set.mode = .cubicBezier
        set.drawValuesEnabled = true
        set.valueFont = .systemFont(ofSize: 10)
        set.valueTextColor = UIColor(red: 240/255, green: 238/255, blue: 70/255, alpha: 1)
    
        set.axisDependency = .left
    
        return LineChartData(dataSet: set)
    }
}
extension ChartCell: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
        print(highlight)
    }
}


extension ChartCell: IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return nameX[Int(value) % nameX.count]
    }
}
