//
//  TCLCollectionViewCell.swift
//  techcongress-listener
//
//  Created by Артём Нешко on 15/05/2019.
//  Copyright © 2019 Артём Нешко. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Localize_Swift

class TFSCollectionViewCell: UICollectionViewCell {
    
    var db = DisposeBag()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        db = DisposeBag()
    }
}
