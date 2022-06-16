//
//  SectionData.swift
//  BaseTableViewKit
//
//  Created by Слава Платонов on 08.02.2022.
//

import UIKit

public typealias State = ArraySection<SectionState, Element>


public struct Element: Differentiable, Hashable {
    
    
    
    public static func == (lhs: Element, rhs: Element) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    
//    public static func == (lhs: Element, rhs: Element) -> Bool {
//        return lhs.hashValue == rhs.hashValue
//    }
    
    public func hash(into hasher: inout Hasher) {
        content.hashValues().forEach {
            hasher.combine($0)
        }
    }
    
    
    public var differenceIdentifier: String {
        return content.id
    }
    
    
    public typealias DifferenceIdentifier = String
    
    
    public init(content: CellData) {
        self.content = content
    }
    
    public func isContentEqual(to source: Element) -> Bool {
        return self == source
    }
    
    
    var content: CellData
    
}

//public struct Element: Differentiable, Hashable {
//
//    public static func == (lhs: Element, rhs: Element) -> Bool {
//        return lhs.id == rhs.id
//    }
//
//    var id : Int {
//        print("Hash value for \(hashValue)")
//        return hashValue
//    }
//
//    public func hash(into hasher: inout Hasher) {
//        content.hashValues().forEach { hasher.combine($0) }
//    }
//
//    var content: CellData
//
//    public init(content: CellData) {
//        self.content = content
//    }
//
//    public var differenceIdentifier: Int {
//        return self.id
//    }
//
//
//    public func isContentEqual(to source: Element) -> Bool {
//        return self == source
//    }
//
//    public typealias DifferenceIdentifier = Int
//}

public struct SectionState : Differentiable {
    
    
    public var differenceIdentifier: String {
        return id
    }
    
    let id: String
    
    public typealias DifferenceIdentifier = String
    
    public func isContentEqual(to source: SectionState) -> Bool {
        return self.differenceIdentifier == source.differenceIdentifier
    }
   
    
    
    var isCollapsed = false
    
    var header: HeaderData?
    var footer: FooterData?
    
    public init(id: String, isCollapsed: Bool = false, header: HeaderData?, footer: FooterData?) {
        self.id = id
        self.isCollapsed = isCollapsed
        self.footer = footer
        self.header = header
    }
}
