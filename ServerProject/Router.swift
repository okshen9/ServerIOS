//
//  Router.swift
//  techcongress-listener
//
//  Created by Артём Нешко on 30/05/2019.
//  Copyright © 2019 Артём Нешко. All rights reserved.
//

import Foundation
import UIKit

enum Router {
    //    case halls
    case week(hall: Month)
    
    private var storyboardName: String {
        switch self {
        case .week: return "CongestionWeekVC"
            
        }
    }
    
    private var viewController: UIViewController? {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        switch self {
            
        case let .week(hall: hall):
            if let vc = storyboard.instantiateInitialViewController() as? CongestionWeekVC {
                vc.viewModel = CongestionWeekViewModel(hall)
                return vc
            }
            return nil
            
        default: return storyboard.instantiateInitialViewController()
        }
    }
    
}

extension Router {
    func push(from navigationController: UINavigationController?, animated: Bool = true) {
        
        guard let vc = viewController else { return }
        navigationController?.pushViewController(vc, animated: animated)
    }
    
    func popTo(from navigationController: UINavigationController?, animated: Bool = true) {
        
        guard let vc = viewController else { return }
        navigationController?.pushViewController(vc, animated: animated)
        
        var vcs = navigationController?.viewControllers
        vcs!.remove(at: vcs!.count - 2)
        navigationController?.setViewControllers(vcs!, animated: true)
    }
    
    func present(from viewController: UIViewController?, modalTransitionStyle: UIModalTransitionStyle = .coverVertical, animated: Bool = true, modalPresentationStyle: UIModalPresentationStyle = .none) {
        guard let vc = self.viewController else { return }
        vc.modalPresentationStyle = modalPresentationStyle
        vc.modalTransitionStyle = modalTransitionStyle
        viewController?.present(vc, animated: animated)
    }
    
    func present2(from viewController: UIViewController?, modalTransitionStyle: UIModalTransitionStyle, animated: Bool = true, modalPresentationStyle: UIModalPresentationStyle) {
        guard let vc = self.viewController else { return }
        vc.modalTransitionStyle = modalTransitionStyle
        viewController?.present(vc, animated: animated)
    }
}
