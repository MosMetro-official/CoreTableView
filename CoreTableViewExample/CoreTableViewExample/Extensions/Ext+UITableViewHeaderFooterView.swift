//
//  Ext+UITableViewHeaderFooterView.swift
//  BaseTableViewKit
//
//  Created by Слава Платонов on 08.02.2022.
//

import UIKit

public extension UITableViewHeaderFooterView {

    static var nib  : UINib {
        return UINib(nibName: identifire, bundle: Bundle.current)
    }

    static var identifire : String {
        return String(describing: self)
    }
}
