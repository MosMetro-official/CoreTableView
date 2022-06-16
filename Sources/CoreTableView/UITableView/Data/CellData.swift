//
//  CellData.swift
//  BaseTableViewKit
//
//  Created by Слава Платонов on 08.02.2022.
//

import UIKit

public protocol CellData {
    
    var id: String { get }
    
    /// Height for element. Mandatory
    var height: CGFloat { get }
    
    func hashValues() -> [Int]
    
    @available(*, deprecated, message: "Use new on onSelect with Command action")
    var onSelect: (() -> Void) { get }
    
    var onItemSelect: Command<Void> { get }
    
    // tint color for cell. Mostly for accessory elements. Default: system
    var tintColor: UIColor { get }
    
    var accesoryType: UITableViewCell.AccessoryType? { get }
    
    var accessoryView: UIView? { get }
    
    /// Set cell content in this method
    func prepare(cell: UITableViewCell, for tableView: UITableView, indexPath: IndexPath)
    
    func didEndDisplaying(cell: UITableViewCell, for tableView: UITableView, indexPath: IndexPath)
    
    /// Creates cell instance, DO NOT SET CONTENT IN THIS METHOD
    /// - Returns: Table cell
    func cell(for tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    
    func cell(for collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell
    
    @available(iOS 13.0, *)
    func menu(for tableView: UITableView, indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration?
}

extension CellData {
    
    public var tintColor: UIColor { return .blue }
    
    public var accesoryType: UITableViewCell.AccessoryType? { return nil }
    
    public var accessoryView: UIView? { return nil }
    
    public var onSelect: (() -> Void) { return {} }
    
    public var onItemSelect: Command<Void>  { return Command(action: {}) }
    
    public func prepare(cell: UITableViewCell, for tableView: UITableView, indexPath: IndexPath) { }
    
    public func cell(for tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        return .init()
    }
    
    public func cell(for collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        return .init()
    }
    
    @available(iOS 13.0, *)
    public func menu(for tableView: UITableView, indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        return nil
    }
    
    public func toElement() -> Element {
        return Element(content: self)
    }
    
    public func didEndDisplaying(cell: UITableViewCell, for tableView: UITableView, indexPath: IndexPath) {}
    
}
