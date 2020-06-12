//
//  HallsNearCell.swift
//  techcongress-listener
//
//  Created by Артём Нешко on 14/05/2019.
//  Copyright © 2019 Артём Нешко. All rights reserved.
//

import UIKit
import Foundation

class HallsNearCell: TFSCollectionViewCell {

    @IBOutlet weak var ibHallsNearLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static func calculateHeight(width: CGFloat) -> CGFloat {
        let title = TCLLocalizedStrings.hallsNear.localized
        let label = UILabel()
        label.numberOfLines = 0
        label.font = TCLFonts.timesNewRoman.ofSize(20)
        label.text = title
        return label.heightThatFitsFor(width: width - 32)
    }

}
