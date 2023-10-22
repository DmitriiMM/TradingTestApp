//
//  CurrencyViewController.swift
//  TradingTestApp
//
//  Created by Дмитрий Мартынов on 20.10.2023.
//

import UIKit

protocol CurrencyViewControllerProtocol: AnyObject {
    func choseCurrency(pair: String)
}

final class CurrencyViewController: UIViewController {
    private var selectedCell: IndexPath?
    weak var delegate: CurrencyViewControllerProtocol?
    
    private let currencyPairs = [
        "EUR / USD", "GBP / USD", "NZD / USD", "AUD / USD", "USD / TRY", "USD / JPY",
        "USD / CAD", "USD / THB", "USD / SGD", "USD / ZAR", "USD / MXN", "USD / CNH",
        "USD / HUF", "USD / HKD"
    ]
    
    // MARK: - Subviews
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = "currencyPair".localized.attributed(font: .interBold(with: 22))
        label.textAlignment = .center
        return label
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = #imageLiteral(resourceName: "arrowLeft")
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 12
        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10.5
        layout.minimumLineSpacing = 20
        layout.sectionInset = UIEdgeInsets(top: 0, left: 37, bottom: 20, right: 37)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.register(CurrencyPairCell.self, forCellWithReuseIdentifier: CurrencyPairCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.0716451928, green: 0.08674214035, blue: 0.1622816324, alpha: 1)
        
        setup()
    }
    
    // MARK: - Private methods
    private func setup() {
        view.addSubview(headerLabel)
        view.addSubview(backButton)
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            headerLabel.heightAnchor.constraint(equalToConstant: 27),
            headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 26),
            headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            headerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            backButton.centerYAnchor.constraint(equalTo: headerLabel.centerYAnchor),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 9),
            
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 83),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc
    private func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Methods
    func setCurrency(_ value: String) {
        guard let index = currencyPairs.firstIndex(where: { $0 == value }) else { return }
        selectedCell = IndexPath(item: index, section: 0)
    }
}

    // MARK: - Delegate
extension CurrencyViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.visibleCells.forEach { $0.backgroundColor = #colorLiteral(red: 0.1962772608, green: 0.2163205445, blue: 0.2839605212, alpha: 1) }
        if let cell = collectionView.cellForItem(at: indexPath) as? CurrencyPairCell {
            selectedCell = indexPath
            cell.select(at: indexPath)
            delegate?.choseCurrency(pair: cell.label.text ?? "")
            backButtonTapped()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CurrencyPairCell {
            cell.backgroundColor = #colorLiteral(red: 0.1962772608, green: 0.2163205445, blue: 0.2839605212, alpha: 1)
        }
    }
}

extension CurrencyViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        currencyPairs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CurrencyPairCell.identifier,
                                                            for: indexPath) as? CurrencyPairCell
        else { return UICollectionViewCell() }
        
        cell.configure(with: currencyPairs[indexPath.row])
        
        guard let selectedCell = selectedCell,
              indexPath == selectedCell else { return cell }
        cell.select(at: selectedCell)
        
        return cell
    }
}

extension CurrencyViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.frame.width / 2 - 46.5)
        let cellHeight: CGFloat = 54
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
