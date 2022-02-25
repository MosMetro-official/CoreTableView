//
//  StandartImageCell.swift
//  BaseTableViewKit
//
//  Created by Слава Платонов on 08.02.2022.
//

import UIKit

public protocol _StandartImage: CellData {
    var title     : String   { get }
    var leftImage : UIImage? { get }
    var separator : Bool     { get }
    var backgroundColor: UIColor? { get }

}

extension _StandartImage {
    
    public var height: CGFloat { return 50 } 
    
    public func hashValues() -> [Int] {
        return [title.hashValue,leftImage.hashValue,separator.hashValue]
    }
    
    public var backgroundColor: UIColor? { return nil }
    
    public func prepare(cell: UITableViewCell, for tableView: UITableView, indexPath: IndexPath) {
        guard let cell = cell as? StandartImageCell else { return }
        cell.configure(with: self)
    }
    
    public func cell(for tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        tableView.register(StandartImageCell.nib, forCellReuseIdentifier: StandartImageCell.identifire)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StandartImageCell.identifire, for: indexPath) as? StandartImageCell else { return .init() }
        return cell
    }
}

class StandartImageCell : UITableViewCell {
    
    @IBOutlet weak private var title : UILabel!
    @IBOutlet weak private var separator : UIView!
    @IBOutlet weak private var leftImage : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        isUserInteractionEnabled = true
    }
    
    override func prepareForReuse() {
        self.title.text = nil
        self.title.textColor = nil
        self.leftImage.image = nil
        self.leftImage.tintColor = nil
    }
    
    func configure(with data: _StandartImage, imageColor: UIColor = .black, boldText: Bool = false, textColor: UIColor = .black) {
        self.title.text = data.title
        self.leftImage.image = data.leftImage
        self.title.textColor = textColor
        self.separator.isHidden = !data.separator
        self.leftImage.tintColor = imageColor
        if boldText {
            self.title.font = UIFont.systemFont(ofSize: 20)
        }
        if let accesory = data.accesoryType {
            self.accessoryType = accesory
        }
        
        if let bgColor = data.backgroundColor  {
            self.backgroundColor = bgColor
        }
    }
}
