//
//  CurrencyPairCell.swift
//  TradingTestApp
//
//  Created by Дмитрий Мартынов on 20.10.2023.
//

import UIKit

class CurrencyPairCell: UICollectionViewCell {
    static let identifier = String(describing: CurrencyPairCell.self)
    
    let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 0.2011670172, green: 0.216167599, blue: 0.2881160975, alpha: 1)
        contentView.addSubview(label)
        label.frame = contentView.bounds
        layer.cornerRadius = 12
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure(with text: String) {
        label.attributedText = text.attributed(font: .sfProTextSemiBold(with: 14))
    }
    
    func select(at indexPath: IndexPath) {
        backgroundColor = #colorLiteral(red: 0.2113476098, green: 0.7277538776, blue: 0.4497774243, alpha: 1)
    }
}
