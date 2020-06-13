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
    var nameX: [String] = ["1", "rrr", "aaa", "4", "5", "6", "7"]
    
    @IBOutlet weak var chartView: CombinedChartView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        chartView.delegate = self
        chartView.scaleXEnabled = true
        chartView.scaleYEnabled = false
        chartView.xAxis.valueFormatter = self
        // Initialization code
    }
    
    func setup(valuePersent: [Entity]) {
        chartView.maxVisibleCount = currentValue.count
        currentValue = []
        staticValue = []
        nameX = []
        for entity in valuePersent {
            nameX.append(" \(entity.name) ")
            currentValue.append(entity.currentPersent)
            staticValue.append(entity.persent)
        }

        let data = CombinedChartData()
        data.barData = generateBarData(valuePersent: valuePersent)
        data.lineData = generateLineData()
        chartView.data = data
        

        
    }
    
    func generateBarData(valuePersent: [Entity]) -> BarChartData {
        var dataEntries: [BarChartDataEntry] = []
        var colors = [UIColor]()
        for i in 0..<valuePersent.count {
            let dataEntry = BarChartDataEntry(x: Double(i + 1), y: Double(valuePersent[i].persent))
            colors.append(UIColor.mixGreenAndRed(greenAmount: Float(100 - valuePersent[i].persent), saturation: 0.7))
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: TCLLocalizedStrings.currentValue.localized)
        chartDataSet.colors = colors
        return BarChartData(dataSet: chartDataSet)
    }
    
    func generateLineData() -> LineChartData {
        let entries = (0..<currentValue.count).map { (i) -> ChartDataEntry in
            return ChartDataEntry(x: Double(i) + 1, y: Double(arc4random_uniform(15) + 5))
        }
    
        let lineColor = UIColor(hexString: "3642B2")
        let set = LineChartDataSet(entries: entries, label: TCLLocalizedStrings.staticValue.localized)
        set.setColor(lineColor)
        set.lineWidth = 2.5
        set.setCircleColor(lineColor)
        set.circleRadius = 5
        set.circleHoleRadius = 2.5
        set.fillColor = lineColor
        set.mode = .cubicBezier
        set.drawValuesEnabled = true
        set.valueFont = .systemFont(ofSize: 10)
        set.valueTextColor = lineColor
    
        set.axisDependency = .left
    
        return LineChartData(dataSet: set)
    }
}
extension ChartCell: ChartViewDelegate, IAxisValueFormatter {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
        print(highlight)
    }
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return nameX[Int(value - 1) % nameX.count]
    }
}
