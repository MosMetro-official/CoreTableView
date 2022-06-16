//
//  HeaderData.swift
//  
//
//  Created by polykuzin on 25.02.2022.
//

import UIKit

public protocol HeaderData {
    
    var id: String { get } 
    
    var height: CGFloat { get }
    
    func header(for tableView: UITableView, section: Int) -> UIView?
}

extension HeaderData {
    
   
    
    public func header(for tableView: UITableView, section: Int) -> UIView? {
        return nil
    }
}
