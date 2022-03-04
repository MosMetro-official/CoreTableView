//
//  MainView.swift
//  BaseTableViewKit_Example
//
//  Created by Слава Платонов on 08.02.2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import CoreTableView

class MainView: UIView {
    
    private var tableView: BaseTableView!
    
    struct ViewState {
        
        var state: [State]
        
        struct Row: _StandartImage {
            var title: String
            var leftImage: UIImage?
            var separator: Bool
            var backgroundColor: UIColor?
            var tintColor: UIColor
            var accesoryType: UITableViewCell.AccessoryType?
            var onSelect: () -> ()
        }
        
        struct Header: _TitleHeaderView {
            var title: String
            var style: TitleHeaderView.Style
            var backgroundColor: UIColor
            var isInsetGrouped: Bool
            var height: CGFloat
        }
    }
    
    public var viewState: ViewState = ViewState(state: []) {
        didSet {
            DispatchQueue.main.async {
                self.tableView.viewStateInput = self.viewState.state
            }
        }
    }
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTableView()
    }
    
    private func setupTableView() {
        tableView = BaseTableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
