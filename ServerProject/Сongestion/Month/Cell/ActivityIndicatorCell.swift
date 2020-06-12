//
//  ActivityIndicatorCell.swift
//  techcongress-listener
//
//  Created by Артём Нешко on 15/05/2019.
//  Copyright © 2019 Артём Нешко. All rights reserved.
//

import UIKit

class ActivityIndicatorCell: UICollectionViewCell {

    @IBOutlet weak var background: UIView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        activityIndicatorView.stopAnimating()
        activityIndicatorView.startAnimating()
    }
    
    
}
