//
//  ExtensionUILabel.swift
//  CoffeeApp
//
//  Created by 김현석 on 2022/09/29.
//

import UIKit

// 패딩 설정
class BasePaddingLabel: UILabel {
    private var padding = UIEdgeInsets(top: 14.0, left: 16.0, bottom: 14.0, right: 16.0)

    convenience init(padding: UIEdgeInsets) {
        self.init()
        self.padding = padding
    }

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }

    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right

        return contentSize
    }
}
