//
//  TextTableViewCell.swift
//  CoreTableViewExample
//
//  Created by Гусейн on 16.06.2022.
//

import UIKit
import CoreTableView

class DummyTextField: UITextField {
    
    
}

public protocol _TextTableViewCell: CellData {
    var text: String? { get set }
    var placeholder: String { get set }
    var onTextEnter: Command<String> { get }
    var onTextFinish: Command<String> { get }
    
}

extension _TextTableViewCell {
    
    public var height: CGFloat { return 50 }
    
    public func hashValues() -> [Int] {
        return [text?.hashValue ?? 0]
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

    @IBOutlet private var textInputField: DummyTextField!
    

    
    private var onTextEnter: Command<String>?
    private var onTextFinish: Command<String>?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textInputField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        textInputField.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        onTextEnter?.perform(with: text)
    }
    
    public func configure(with data: _TextTableViewCell) {
        textInputField.text = data.text
        textInputField.placeholder = data.placeholder
        self.onTextEnter = data.onTextEnter
        self.onTextFinish = data.onTextFinish
    }
}

extension TextTableViewCell: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.onTextFinish?.perform(with: textField.text ?? "")
    }
}
