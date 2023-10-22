//
//  TopCell.swift
//  TradingTestApp
//
//  Created by Дмитрий Мартынов on 18.10.2023.
//

import UIKit

final class TopCell: UITableViewCell {
    static let identifier = String(describing: TopCell.self)
    
    private lazy var numberLabel = UILabel()
    private lazy var countryLabel = UILabel()
    private lazy var nameLabel = UILabel()
    private lazy var depositLabel = UILabel()
    private lazy var profitLabel = UILabel()
    
    private lazy var countryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .equalCentering
        
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupStackView() {
        contentView.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        countryLabel.translatesAutoresizingMaskIntoConstraints = false
        countryImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        depositLabel.translatesAutoresizingMaskIntoConstraints = false
        profitLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 9),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -9),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }
    
    func configureHeaderCell() {
        stackView.arrangedSubviews.forEach { stackView.removeArrangedSubview($0) }
        stackView.addArrangedSubview(numberLabel)
        stackView.addArrangedSubview(countryLabel)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(depositLabel)
        stackView.addArrangedSubview(profitLabel)
        
        let textColor = #colorLiteral(red: 0.7559762001, green: 0.7609493136, blue: 0.7823577523, alpha: 1)
        numberLabel.attributedText = "number".localized.attributed(font: .interMedium(with: 12), color: textColor)
        countryLabel.attributedText = "country".localized.attributed(font: .interMedium(with: 12), color: textColor)
        nameLabel.attributedText = "name".localized.attributed(font: .interMedium(with: 12), color: textColor)
        depositLabel.attributedText = "deposit".localized.attributed(font: .interMedium(with: 12), color: textColor)
        profitLabel.attributedText = "profit".localized.attributed(font: .interMedium(with: 12), color: textColor)
        
        stackView.arrangedSubviews.enumerated().forEach { index, view in
            guard let label = view as? UILabel else { return }
            label.textAlignment = index < 3 ? .left : .right
        }
    }
    
    func configure(by trader: Trader, at place: Int) {
        stackView.arrangedSubviews.forEach { stackView.removeArrangedSubview($0) }
        
        let textGrayColor = #colorLiteral(red: 0.7559762001, green: 0.7609493136, blue: 0.7823577523, alpha: 1)
        let textGreenColor = #colorLiteral(red: 0.2113476098, green: 0.7277538776, blue: 0.4497774243, alpha: 1)
        
        numberLabel.attributedText = String(place).attributed(font: .interMedium(with: 14), color: textGrayColor)
        countryImageView.image = UIImage(named: trader.country)
        nameLabel.attributedText = trader.name.attributed(font: .interMedium(with: 14))
        depositLabel.attributedText = "$\(trader.deposit)".attributed(font: .interMedium(with: 14))
        profitLabel.attributedText = "$\(trader.profit)".attributed(font: .interMedium(with: 14), color: textGreenColor)
        
        depositLabel.textAlignment = .right
        profitLabel.textAlignment = .right
        
        stackView.addArrangedSubview(numberLabel)
        stackView.addArrangedSubview(countryImageView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(depositLabel)
        stackView.addArrangedSubview(profitLabel)
    }
}
