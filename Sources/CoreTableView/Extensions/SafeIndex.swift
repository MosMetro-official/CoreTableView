//
//  SafeIndex.swift
//  
//
//  Created by Слава Платонов on 08.02.2022.
//

import Foundation

public extension Collection {
    
    subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
