//
//  UIFont+Extensions.swift
//  TradingTestApp
//
//  Created by Дмитрий Мартынов on 18.10.2023.
//

import UIKit

extension UIFont {
    static var defaultFontSize: CGFloat {
        10
    }
    
    static func interExtraBold(with size: CGFloat = defaultFontSize) -> UIFont {
        return UIFont(name: "Inter-ExtraBold", size: size)
            ?? UIFont.systemFont(ofSize: size, weight: .bold)
    }
    
    static func interBold(with size: CGFloat = defaultFontSize) -> UIFont {
        return UIFont(name: "Inter-Bold", size: size)
            ?? UIFont.systemFont(ofSize: size, weight: .bold)
    }
    
    static func interMedium(with size: CGFloat = defaultFontSize) -> UIFont {
        return UIFont(name: "Inter-Medium", size: size)
            ?? UIFont.systemFont(ofSize: size, weight: .regular)
    }

    static func sfProTextBold(with size: CGFloat = defaultFontSize) -> UIFont {
        return UIFont(name: "SFProText-Bold", size: size)
            ?? UIFont.systemFont(ofSize: size, weight: .regular)
    }
    
    static func sfProTextSemiBold(with size: CGFloat = defaultFontSize) -> UIFont {
        return UIFont(name: "SFProText-Semibold", size: size)
            ?? UIFont.systemFont(ofSize: size, weight: .bold)
    }

}

