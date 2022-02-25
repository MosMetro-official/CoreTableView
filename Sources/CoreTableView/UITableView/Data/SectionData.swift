//
//  SectionData.swift
//  BaseTableViewKit
//
//  Created by Слава Платонов on 08.02.2022.
//

import UIKit

public typealias State = ArraySection<SectionState, Element>

public struct Element: ContentEquatable, ContentIdentifiable, Hashable {
    
    public static func == (lhs: Element, rhs: Element) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    var id : Int {
        print("Hash value for \(hashValue)")
        return hashValue
    }
    
    var content: CellData
    
    public init(content: CellData) {
        self.content = content
    }
    
    public var differenceIdentifier: Int {
        return self.id
    }
    
    public func hash(into hasher: inout Hasher) {
        let hashValues = content.hashValues()
        hashValues.forEach { value in
            hasher.combine(value)
        }
    }
    
    public func isContentEqual(to source: Element) -> Bool {
        return self.id == source.id
    }
}

public struct SectionState : Differentiable, Equatable, Hashable {
    
    public var differenceIdentifier: Int {
        return hashValue
    }
    
    public static func == (lhs: SectionState, rhs: SectionState) -> Bool {
        return lhs.differenceIdentifier == rhs.differenceIdentifier
    }
    
    public func hash(into hasher: inout Hasher) {
        let headerHash = header?.hashValues() ?? [Int.random(in: 0..<1000000)]
        let footerHash = footer?.hashValues() ?? [Int.random(in: 0..<1000000)]
        headerHash.forEach { value in
            hasher.combine(value)
        }
        footerHash.forEach { value in
            hasher.combine(value)
        }
    }
    
    var isCollapsed = false
    
    var header: HeaderData?
    var footer: FooterData?
    
    public init(isCollapsed: Bool = false, header: HeaderData?, footer: FooterData?) {
        self.isCollapsed = isCollapsed
        self.footer = footer
        self.header = header
    }
}
