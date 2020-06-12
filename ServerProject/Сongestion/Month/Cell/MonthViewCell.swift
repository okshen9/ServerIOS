//
//  MonthViewCell.swift
//  ServerProject
//
//  Created by Artem Neshko on 5/24/20.
//  Copyright © 2020 Artem Neshko. All rights reserved.
//

import UIKit

class MonthViewCell: TFSCollectionViewCell {
    
    @IBOutlet weak var percentageLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var backView: CustomView!
    var persent = 0
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var progress: UIProgressView!
    
    var gradientLayer: CAGradientLayer?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        createGradientLayer()
        // Initialization code
    }
    
    private static var count = 0
    
    func setup(name: String, persent: Int) {
        
        UIView.animate(withDuration: 3, animations: {
            self.percentageLabel.text = "\(persent)%"
            self.name.text = name.firstUppercased
        })
        self.progress.setProgress(Float(persent) / 100, animated: false)
        self.gradientLayer?.colors = [UIColor.clear.cgColor, UIColor.mixGreenAndRed(greenAmount: Float(100 - persent)).cgColor]
        self.persent = persent
        
        createGradientLayer()
        descriptionLabel.text = (String.getLoadStr(per: persent))
        
    }
    
    func createGradientLayer() {
        
        gradientLayer = CAGradientLayer()
        gradientLayer?.frame = self.backView.bounds
        
        gradientLayer?.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer?.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer?.cornerRadius = 10
        if gradientLayer != nil {
        self.backView.layer.insertSublayer(gradientLayer!, at: 0)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        persent = 0
        self.gradientLayer = nil
    }
    
    static func calculateHeight(for title: String, per: Int, width: CGFloat) -> CGFloat {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = TCLFonts.timesNewRomanBold.ofSize(21)
        label.text = title
        
        let label2 = UILabel()
        label2.numberOfLines = 0
        
        label2.font = UIFont.systemFont(ofSize: 17)
        label2.text = String.getLoadStr(per: per)
        
        return label.heightThatFitsFor(width: width - 64.4) + 50 //65.4 - indent from the edge of the screen to the label
        //44 - vertical indents to the edges of the cell
    }
    
}
