//
//  File.swift
//  
//
//  Created by guseyn on 08.04.2022.
//

import Foundation

public struct Command<T> {
    
    private var action: (T) -> Void
    
    public init(action: @escaping (T) -> Void) {
        self.action = action
    }
    
    public func perform(with value: T) {
        self.action(value)
    }
    
}
