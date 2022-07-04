//
//  FooterData.swift
//  
//
//  Created by polykuzin on 25.02.2022.
//

import UIKit

public protocol FooterData {
    
    var id : String { get }
    
    var height : CGFloat { get }
    
    func footer(for tableView: UITableView, section: Int) -> UIView?
}

extension FooterData {
    
    public func footer(for tableView: UITableView, section: Int) -> UIView? {
        return nil
    }
}
