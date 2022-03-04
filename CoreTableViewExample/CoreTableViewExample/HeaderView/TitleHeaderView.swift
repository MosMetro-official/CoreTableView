//
//  TitleHeaderView.swift
//  BaseTableViewKit
//
//  Created by Слава Платонов on 08.02.2022.
//

import UIKit
import CoreTableView

public protocol _TitleHeaderView : HeaderData {
    var title: String { get }
    var style: TitleHeaderView.Style { get }
    var backgroundColor: UIColor { get }
    var isInsetGrouped: Bool { get }
}

extension _TitleHeaderView {
    
    public func hashValues() -> [Int] {
        return [title.hashValue,style.hashValue,backgroundColor.hashValue,isInsetGrouped.hashValue]
    }
    
    public var height: CGFloat {
        switch self.style {
        case .large:
            return 28
        case .medium:
            return 22
        case .small:
            return 18
        }
    }
    
    public func header(for tableView: UITableView, section: Int) -> UIView? {
        tableView.register(TitleHeaderView.nib, forHeaderFooterViewReuseIdentifier: TitleHeaderView.identifire)
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: TitleHeaderView.identifire) as? TitleHeaderView else { return nil }
        headerView.configure(self)
        return headerView
    }
}

public class TitleHeaderView: UITableViewHeaderFooterView {
    
    public enum Style {
        case large
        case medium
        case small
        
        var font: UIFont {
            switch self {
            case .large:
                return UIFont.systemFont(ofSize: 22, weight: .bold)
            case .medium:
                return UIFont.systemFont(ofSize: 17, weight: .medium)
            case .small:
                return UIFont.systemFont(ofSize: 13, weight: .regular)
            }
        }
    }
    
    @IBOutlet private weak var leftLabelConstaint: NSLayoutConstraint!
    @IBOutlet private weak var backView: UIView!
    @IBOutlet private weak var mainTitleLabel: UILabel!

    func configure(_ data: _TitleHeaderView) {
        self.mainTitleLabel.font = data.style.font
        self.mainTitleLabel.text = data.title
        self.backView.backgroundColor = data.backgroundColor
        self.leftLabelConstaint.constant = data.isInsetGrouped ? 20 : 16
        self.layoutIfNeeded()
    }
}
