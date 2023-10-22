//
//  TopViewController.swift
//  TradingTestApp
//
//  Created by Дмитрий Мартынов on 18.10.2023.
//

import UIKit

final class TopViewController: UIViewController {
    private var topTraders = [
        Trader(name: "Oliver", country: "usa", deposit: 2367, profit: 336755),
        Trader(name: "Jack", country: "canada", deposit: 1175, profit: 148389),
        Trader(name: "Harry", country: "brazil", deposit: 1000, profit: 113888),
        Trader(name: "Jacob", country: "south-korea", deposit: 999, profit: 36755),
        Trader(name: "Charley", country: "germany", deposit: 888, profit: 18389),
        Trader(name: "Thomas", country: "brazil", deposit: 777, profit: 12000),
        Trader(name: "George", country: "france", deposit: 666, profit: 11111),
        Trader(name: "Oscar", country: "new-zealand", deposit: 555, profit: 9988),
        Trader(name: "James", country: "india", deposit: 444, profit: 8877),
        Trader(name: "William", country: "spain", deposit: 333, profit: 6652),
    ]
    
    // MARK: - Subviews
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = "topTenTraders".localized.attributed(font: .interBold(with: 22))
        label.textAlignment = .center
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(TopCell.self, forCellReuseIdentifier: TopCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.bounces = true
        tableView.layer.cornerRadius = 9
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.111887224, green: 0.1218894795, blue: 0.1768437028, alpha: 1)
        
        setup()
        Timer.scheduledTimer(timeInterval: 5.0,
                             target: self,
                             selector: #selector(updateRandomRowValue),
                             userInfo: nil,
                             repeats: true)
    }
    
    // MARK: - Private methods
    private func setup() {
        view.addSubview(headerLabel)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            headerLabel.heightAnchor.constraint(equalToConstant: 27),
            headerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 64),
            headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            headerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            tableView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 29),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            tableView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12),
            tableView.heightAnchor.constraint(equalToConstant: CGFloat((topTraders.count + 1) * 50))
        ])
    }
    
    @objc
    private func updateRandomRowValue() {
        let randomTradersCount = Int.random(in: 0..<topTraders.count)
        
        var randomTraders = [Int]()
        while randomTraders.count < randomTradersCount {
            if let randomIndex = topTraders.indices.randomElement() {
                randomTraders.append(topTraders.indices[randomIndex])
            }
        }
        
        for trader in randomTraders {
            topTraders[trader].profit += Int.random(in: 50...150)
            topTraders[trader].deposit += Int.random(in: 50...150)
            
            let indexPath = IndexPath(row: 1 + trader, section: 0)
            tableView.reloadRows(at: [indexPath], with: .fade)
        }
    }
}

// MARK: - Delegate
extension TopViewController: UITableViewDelegate { }

extension TopViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        topTraders.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TopCell.identifier,
                                                       for: indexPath) as? TopCell else { return UITableViewCell() }
        if indexPath.row == 0 {
            cell.configureHeaderCell()
        } else {
            cell.configure(by: topTraders[indexPath.row - 1], at: indexPath.row)
        }
        
        if indexPath.row % 2 != 1 {
            cell.backgroundColor = #colorLiteral(red: 0.1785746515, green: 0.1885589957, blue: 0.2436981201, alpha: 1)
        } else {
            cell.backgroundColor = .clear
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50.0
    }
}
