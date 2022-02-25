//
//  FooterData.swift
//  
//
//  Created by polykuzin on 25.02.2022.
//

import UIKit

public protocol FooterData {
    
    var height: CGFloat { get }
    
    func hashValues() -> [Int]
    
    func footer(for tableView: UITableView, section: Int) -> UIView?
}

extension FooterData {
    
    public func hashValues() -> [Int] {
        return [Int.random(in: 0...22000)]
    }
    
    public func footer(for tableView: UITableView, section: Int) -> UIView? {
        return nil
    }
}
