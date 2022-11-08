//
//  SectionData.swift
//  BaseTableViewKit
//
//  Created by Слава Платонов on 08.02.2022.
//

import UIKit
import DifferenceKit

public typealias State = ArraySection<SectionState, Element>

public struct Element: Differentiable, Hashable {
    
    var content : CellData
    
    public init(content: CellData) {
        self.content = content
    }
    
    public var differenceIdentifier : String {
        return content.id
    }
    
    public func hash(into hasher: inout Hasher) {
        content.hashValues().forEach {
            hasher.combine($0)
        }
    }
    
    public typealias DifferenceIdentifier = String
    
    public func isContentEqual(to source: Element) -> Bool {
        return self == source
    }
    
    public static func == (lhs: Element, rhs: Element) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}

public struct SectionState : Differentiable {
    
    public let id : String
        
    public var header : HeaderData?
    
    public var footer : FooterData?
    
    public var isCollapsed = false
    
    public var differenceIdentifier: String {
        return id
    }
    
    public typealias DifferenceIdentifier = String
    
    public func isContentEqual(to source: SectionState) -> Bool {
        return self.differenceIdentifier == source.differenceIdentifier
    }
    
    public init(id: String, isCollapsed: Bool = false, header: HeaderData? = nil, footer: FooterData? = nil) {
        self.id = id
        self.isCollapsed = isCollapsed
        self.footer = footer
        self.header = header
    }
}
