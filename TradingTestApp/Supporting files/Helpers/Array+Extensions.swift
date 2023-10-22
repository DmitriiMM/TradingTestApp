//
//  Array+Extensions.swift
//  TradingTestApp
//
//  Created by Дмитрий Мартынов on 21.10.2023.
//

import Foundation

extension Array {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
