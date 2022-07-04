//
//  Ext+String.swift
//  
//
//  Created by polykuzin on 03.03.2022.
//

import UIKit

extension String {
    
    public func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.height)
    }
    
    public func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.width)
    }
}

extension NSAttributedString {
    
    public func height(containerWidth: CGFloat) -> CGFloat {
        let rect = self.boundingRect(
            with: CGSize.init(width: containerWidth, height: CGFloat.greatestFiniteMagnitude),
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            context: nil
        )
        return ceil(rect.size.height)
    }
    
    public func width(containerHeight: CGFloat) -> CGFloat {
        let rect = self.boundingRect(
            with: CGSize.init(width: CGFloat.greatestFiniteMagnitude, height: containerHeight),
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            context: nil
        )
        return ceil(rect.size.width)
    }
}
