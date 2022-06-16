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
            var id: String
            
            var title: String
            var leftImage: UIImage?
            var separator: Bool
            var backgroundColor: UIColor?
            var tintColor: UIColor
            var accesoryType: UITableViewCell.AccessoryType?
            var onSelect: () -> ()
        }
        
        struct Header: _TitleHeaderView {
            var id: String
            var title: String
            var style: TitleHeaderView.Style
            var backgroundColor: UIColor
            var isInsetGrouped: Bool
            var height: CGFloat
        }
        
        struct Text: _TextTableViewCell {
            var text: String?
            
            var placeholder: String
            
            var onTextEnter: Command<String>
            
            var id: String
            
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
        NotificationCenter.default.addObserver(self,
               selector: #selector(self.keyboardNotification(notification:)),
               name: UIResponder.keyboardWillChangeFrameNotification,
               object: nil)
        
        tableView = BaseTableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableView)
        backgroundColor = .systemBackground
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    
    @objc func keyboardNotification(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        
        guard let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        let endFrameY = endFrame.origin.y
        let endFrameHeight = endFrame.height
        let duration: TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
        let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
        let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
        let animationCurve: UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)
        
        if endFrameY >= UIScreen.main.bounds.size.height {
            self.tableView.contentInset = UIEdgeInsets(top: 24, left: 0, bottom: 0, right: 0)
        } else {
            self.tableView.contentInset = UIEdgeInsets(top: 24, left: 0, bottom: endFrameHeight + 44, right: 0)
            tableView.setContentOffset(tableView.contentOffset, animated:false)
        }
        print("END FRAME - \(endFrame), endFrameY - \(endFrameY)")
        UIView.animate(
            withDuration: duration,
            delay: TimeInterval(0),
            options: animationCurve,
            animations: { self.layoutIfNeeded() },
            completion: nil)
    }
}
