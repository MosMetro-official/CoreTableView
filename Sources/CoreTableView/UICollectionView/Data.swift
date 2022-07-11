//
//  File.swift
//  
//
//  Created by guseyn on 11.07.2022.
//

import Foundation
import UIKit


public typealias CollectionState = ArraySection<CollectionSectionState, CollectionElement>

public struct CollectionElement: Differentiable, Hashable {
    
    let content : CollectionViewModel
    
    public init(content: CollectionViewModel) {
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
    
    public func isContentEqual(to source: CollectionElement) -> Bool {
        return self == source
    }
    
    public static func == (lhs: CollectionElement, rhs: CollectionElement) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}

public struct CollectionSectionState : Differentiable {
    
    public let id : String
        
    public var isCollapsed = false
    
    public var differenceIdentifier: String {
        return id
    }
    
    public typealias DifferenceIdentifier = String
    
    public func isContentEqual(to source: CollectionSectionState) -> Bool {
        return self.differenceIdentifier == source.differenceIdentifier
    }
    
    public init(id: String, isCollapsed: Bool = false) {
        self.id = id
        self.isCollapsed = isCollapsed
        
    }
}


public protocol CollectionViewModel: BaseCellViewModel {
    
    var size: CGSize { get set }
    
    func cell(for collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    
    func willDisplay(cell: UICollectionViewCell, for collectionView: UICollectionView, indexPath: IndexPath)
    
}

public extension CollectionViewModel {
    
    func element() -> CollectionElement {
        return CollectionElement(content: self)
    }
    
    var onItemSelect: Command<Void> { return Command { _ in } }
    
}
