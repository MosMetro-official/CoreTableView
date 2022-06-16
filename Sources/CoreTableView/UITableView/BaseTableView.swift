//
//  BaseTableView.swift
//  
//
//  Created by polykuzin on 25.02.2022.
//

import UIKit

public typealias MenuData = (tableView: UITableView, indexPath: IndexPath, point: CGPoint, element: Any)
public typealias TableData = (tableView: UITableView, indexPath: IndexPath, element: Any)
public typealias CellDisplayData = (tableView: UITableView, cell: UITableViewCell, indexPath: IndexPath, element: Any)
public typealias CellWillDisplayData = (tableView: UITableView, cell: UITableViewCell, indexPath: IndexPath)

public class BaseTableView: UITableView {
    
    /// original data source
    private var viewState = [State]()
    public var rowAnimation: UITableView.RowAnimation = .fade
    public var shouldUseReload = false
    
    /// public data source. Affects original, used only for diff calculattions
    public var viewStateInput: [State] {
        get {
            return viewState
        }
        set {
            let changeset = StagedChangeset(source: viewState, target: newValue)
            self.reload(using: changeset, with: rowAnimation, interrupt: { [weak self] change in
                guard let self = self else { return false }
                return self.shouldUseReload }) { newState in
                self.viewState = newState
            }
        }
    }
    
    public var onScroll: ((UIScrollView) -> ())?
    public var onWillDisplay: ((CellWillDisplayData) -> Void)?
     
    override public init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        delegate = self
        dataSource = self
        estimatedRowHeight = 0
        estimatedSectionHeaderHeight = 0
        estimatedSectionFooterHeight = 0
    }
}

extension BaseTableView: UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return viewState.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewState[section].model.isCollapsed ? 0 : viewState[section].elements.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let element = self.viewState[safe: indexPath.section]?.elements[safe: indexPath.row]?.content
        else { return .init() }
        return element.cell(for: tableView, indexPath: indexPath)
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard
            let element = self.viewState[safe: indexPath.section]?.elements[safe: indexPath.row]?.content
        else { return }
        self.onWillDisplay?((tableView: tableView, cell: cell, indexPath: indexPath))
        element.prepare(cell: cell, for: tableView, indexPath: indexPath)
    }
    
    public func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard
            let element = self.viewState[safe: indexPath.section]?.elements[safe: indexPath.row]?.content
        else { return }
        element.didEndDisplaying(cell: cell, for: tableView, indexPath: indexPath)
    }
}

extension BaseTableView: UITableViewDelegate {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.onScroll?(scrollView)
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard
            let headerData = self.viewState[section].model.header
        else { return nil }
        return headerData.header(for: tableView, section: section)
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard
            let footerData = self.viewState[section].model.footer
        else { return nil }
        return footerData.footer(for: tableView, section: section)
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard
            let element = self.viewState[safe: indexPath.section]?.elements[safe: indexPath.row]?.content
        else { return 44 }
        return element.height
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard
            let headerData = self.viewState[section].model.header
        else { return 0 }
        return headerData.height
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        guard
            let footerData = self.viewState[section].model.footer
        else { return 0 }
        return footerData.height
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard
            let element = self.viewState[safe: indexPath.section]?.elements[safe: indexPath.row]?.content
        else { return }
        element.onSelect()
        element.onItemSelect.perform(with: ())
        deselectRow(at: indexPath, animated: true)
    }
    
    @available(iOS 13.0, *)
    public func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        guard
            let element = self.viewState[safe: indexPath.section]?.elements[safe: indexPath.row]?.content
        else { return nil }
        return element.menu(for: tableView, indexPath: indexPath, point: point)
    }
}
