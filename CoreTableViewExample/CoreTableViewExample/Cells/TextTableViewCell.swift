//
//  TextTableViewCell.swift
//  CoreTableViewExample
//
//  Created by Гусейн on 16.06.2022.
//

import UIKit
import CoreTableView

public protocol _TextTableViewCell: CellData {
    var text: String? { get set }
    var placeholder: String { get set }
    var onTextEnter: Command<String> { get }
    
}

extension _TextTableViewCell {
    
    public var height : CGFloat { return 50 }
    
    public func hashValues() -> [Int] {
        return []
    }
    
    public func prepare(cell: UITableViewCell, for tableView: UITableView, indexPath: IndexPath) {
        guard let cell = cell as? TextTableViewCell else { return }
        cell.configure(with: self)
    }
    
    public func cell(for tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        tableView.register(TextTableViewCell.nib, forCellReuseIdentifier: TextTableViewCell.identifire)
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: TextTableViewCell.identifire, for: indexPath) as? TextTableViewCell
        else { return .init() }
        return cell
    }
    
    public func didEndDisplaying(cell: UITableViewCell, for tableView: UITableView, indexPath: IndexPath) {
        guard let cell = cell as? TextTableViewCell else { return }
        cell.configure(with: self)
    }
}

class TextTableViewCell: UITableViewCell {

    @IBOutlet private var textInputField: UITextField!
    
    private var onTextEnter : Command<String>?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textInputField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc
    func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        onTextEnter?.perform(with: text)
    }
    
    public func configure(with data: _TextTableViewCell) {
        textInputField.text = data.text
        textInputField.placeholder = data.placeholder
        self.onTextEnter = data.onTextEnter
    }
}
