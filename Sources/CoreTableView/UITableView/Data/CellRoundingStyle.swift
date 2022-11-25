//
//  File.swift
//  
//
//  Created by Гусейн on 25.11.2022.
//

import Foundation
import UIKit

public enum CellRoundingStyle {
    case start
    case middle
    case end
    case single
    
    
    public static func getStyle(for index: Int, totalElements: Int) -> CellRoundingStyle {
        if totalElements == 1 {
            return .single
        }
        
        if index == 0 {
            return .start
        }
        
        if index == (totalElements - 1) {
            return .end
        }
        
        return .middle
    }
    
    public func round(cell: UITableViewCell) {
        switch self {
        case .start:
            cell.roundCorners(.top, radius: 16)
        case .middle:
            cell.roundCorners(.all, radius: 0)
        case .end:
            cell.roundCorners(.bottom, radius: 16)
        case .single:
            cell.roundCorners(.all, radius: 16)
        }
    }
    
}
