//
//  ProjectStatus.swift
//  Connect
//
//  Created by David Petrosyan on 4/2/20.
//  Copyright © 2020 EPAM. All rights reserved.
//

/// Describes project health status
enum DeliveryStatusType: Int {
    case green
    case amber
    case red
    case gray
    
    var strName: String {
        switch self {
        case .green:
            return  "GREEN"
        case .red:
            return "RED"
        case .amber:
            return "AMBER"
        case .gray:
            return "GRAY"
        }
    }
}

/// Describes project status on timeline
enum ProjectStatusTime: Int {
    case previous
    case current
    case forecast
}

/// Describes search result type
enum DeliverySearchResultType: Int {
	case project
	case account
	case none
}

struct ProjectStatus {
    var type: DeliveryStatusType
    var time: ProjectStatusTime
}
