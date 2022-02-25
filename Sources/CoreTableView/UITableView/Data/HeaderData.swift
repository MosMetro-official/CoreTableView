//
//  HeaderData.swift
//  
//
//  Created by polykuzin on 25.02.2022.
//

import UIKit

public protocol HeaderData {
    
    var height: CGFloat { get }
    
    func hashValues() -> [Int]
    
    func header(for tableView: UITableView, section: Int) -> UIView?
}

extension HeaderData {
    
    public func hashValues() -> [Int] {
        return [Int.random(in: 0...22000)]
    }
    
    public func header(for tableView: UITableView, section: Int) -> UIView? {
        return nil
    }
}
