//
//  String+Extensions.swift
//  TradingTestApp
//
//  Created by Дмитрий Мартынов on 18.10.2023.
//

import UIKit

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func attributed(font: UIFont = .interBold(), color: UIColor = .white) -> NSAttributedString {
        NSAttributedString(string: self, attributes: [.font: font,
                                                      .foregroundColor: color])
    }
}
