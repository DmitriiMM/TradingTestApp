//
//  TradeViewController.swift
//  TradingTestApp
//
//  Created by Дмитрий Мартынов on 18.10.2023.
//

import UIKit

final class TradeViewController: UIViewController {
    private var buttonsContainerBottomConstraint: NSLayoutConstraint?
    
    // MARK: - Subviews
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = "trade".localized.attributed(font: .interBold(with: 22))
        label.textAlignment = .center
        return label
    }()
    
    private lazy var balanceView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.2011670172, green: 0.216167599, blue: 0.2881160975, alpha: 1)
        view.layer.cornerRadius = 12
        return view
    }()
    
    private lazy var balanceNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let textColor = #colorLiteral(red: 0.7843136787, green: 0.7843136787, blue: 0.7843136787, alpha: 1)
        label.attributedText = "balance".localized.attributed(font: .interMedium(with: 12), color: textColor)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var balanceAmountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private lazy var chartView = ChartWebView()
    
    private lazy var buttonsContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.0716451928, green: 0.08674214035, blue: 0.1622816324, alpha: 1)
        return view
    }()
    
    private lazy var currencyButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = #colorLiteral(red: 0.2011670172, green: 0.216167599, blue: 0.2881160975, alpha: 1)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(currencyButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var currencyButtonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "arrowRight")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var timerView = TradeSettingsView(type: .timer)
    private lazy var investmentView = TradeSettingsView(type: .investment)
    
    private lazy var sellButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = #colorLiteral(red: 0.9957339168, green: 0.2396890819, blue: 0.2649739385, alpha: 1)
        button.layer.cornerRadius = 12
        button.setAttributedTitle("sell".localized.attributed(font: .interMedium(with: 24)), for: .normal)
        button.setAttributedTitle("sell".localized.attributed(font: .interMedium(with: 24), color: .lightGray), for: .highlighted)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 77)
        button.addTarget(self, action: #selector(sellButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var buyButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = #colorLiteral(red: 0.2057933807, green: 0.7238125801, blue: 0.4457931519, alpha: 1)
        button.layer.cornerRadius = 12
        button.setAttributedTitle("buy".localized.attributed(font: .interMedium(with: 24)), for: .normal)
        button.setAttributedTitle("buy".localized.attributed(font: .interMedium(with: 24), color: .lightGray), for: .highlighted)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 77)
        button.addTarget(self, action: #selector(buyButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.0716451928, green: 0.08674214035, blue: 0.1622816324, alpha: 1)
        observeKeyboardAppearing()
        addObservers()
        
        setup()
        setupSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        chartView.loadChart(for: BalanceManager.shared.lastCurrencyPair)
    }
    
    deinit {
        removeKeyBoardNotifications()
    }
    
    // MARK: - Private methods
    private func setup() {
        timerView.translatesAutoresizingMaskIntoConstraints = false
        investmentView.translatesAutoresizingMaskIntoConstraints = false
        chartView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(headerLabel)
        view.addSubview(balanceView)
        balanceView.addSubview(balanceNameLabel)
        balanceView.addSubview(balanceAmountLabel)
        view.addSubview(chartView)
        view.addSubview(buttonsContainerView)
        buttonsContainerView.addSubview(currencyButton)
        buttonsContainerView.addSubview(timerView)
        buttonsContainerView.addSubview(investmentView)
        buttonsContainerView.addSubview(sellButton)
        buttonsContainerView.addSubview(buyButton)
        currencyButton.addSubview(currencyButtonImageView)
        
        NSLayoutConstraint.activate([
            headerLabel.heightAnchor.constraint(equalToConstant: 27),
            headerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 64),
            headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            headerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            balanceView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            balanceView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            balanceView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 15),
            balanceView.heightAnchor.constraint(equalToConstant: 54),
            
            balanceNameLabel.centerXAnchor.constraint(equalTo: balanceView.centerXAnchor),
            balanceNameLabel.bottomAnchor.constraint(equalTo: balanceView.centerYAnchor, constant: -7),
            
            balanceAmountLabel.centerXAnchor.constraint(equalTo: balanceView.centerXAnchor),
            balanceAmountLabel.topAnchor.constraint(equalTo: balanceView.centerYAnchor),
            
            chartView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            chartView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            chartView.topAnchor.constraint(equalTo: balanceView.bottomAnchor, constant: 25),
            chartView.heightAnchor.constraint(lessThanOrEqualToConstant: UIScreen.main.bounds.height * 0.4),
            
            buttonsContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            buttonsContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            buttonsContainerView.topAnchor.constraint(equalTo: chartView.bottomAnchor),
            buttonsContainerView.heightAnchor.constraint(equalToConstant: 202),
            
            currencyButton.widthAnchor.constraint(equalToConstant: 315),
            currencyButton.centerXAnchor.constraint(equalTo: buttonsContainerView.centerXAnchor),
            currencyButton.leadingAnchor.constraint(greaterThanOrEqualTo: buttonsContainerView.leadingAnchor, constant: 30),
            currencyButton.trailingAnchor.constraint(greaterThanOrEqualTo: buttonsContainerView.trailingAnchor, constant: -30),
            currencyButton.topAnchor.constraint(equalTo: buttonsContainerView.topAnchor, constant: 21),
            currencyButton.heightAnchor.constraint(equalToConstant: 54),
            
            timerView.leadingAnchor.constraint(equalTo: currencyButton.leadingAnchor),
            timerView.heightAnchor.constraint(equalTo: currencyButton.heightAnchor),
            timerView.topAnchor.constraint(equalTo: currencyButton.bottomAnchor, constant: 10),
            timerView.trailingAnchor.constraint(equalTo: currencyButton.centerXAnchor, constant: -5.5),
            
            sellButton.leadingAnchor.constraint(equalTo: currencyButton.leadingAnchor),
            sellButton.heightAnchor.constraint(equalTo: currencyButton.heightAnchor),
            sellButton.topAnchor.constraint(equalTo: timerView.bottomAnchor, constant: 10),
            sellButton.trailingAnchor.constraint(equalTo: currencyButton.centerXAnchor, constant: -5.5),
            
            investmentView.trailingAnchor.constraint(equalTo: currencyButton.trailingAnchor),
            investmentView.heightAnchor.constraint(equalTo: currencyButton.heightAnchor),
            investmentView.topAnchor.constraint(equalTo: currencyButton.bottomAnchor, constant: 10),
            investmentView.leadingAnchor.constraint(equalTo: currencyButton.centerXAnchor, constant: 5.5),
            
            buyButton.trailingAnchor.constraint(equalTo: currencyButton.trailingAnchor),
            buyButton.heightAnchor.constraint(equalTo: currencyButton.heightAnchor),
            buyButton.topAnchor.constraint(equalTo: investmentView.bottomAnchor, constant: 10),
            buyButton.leadingAnchor.constraint(equalTo: currencyButton.centerXAnchor, constant: 5.5),
            buyButton.bottomAnchor.constraint(equalTo: buttonsContainerView.bottomAnchor, constant: -12),
            
            currencyButtonImageView.centerYAnchor.constraint(equalTo: currencyButton.centerYAnchor),
            currencyButtonImageView.trailingAnchor.constraint(equalTo: currencyButton.trailingAnchor, constant: -11)
        ])
        
        buttonsContainerBottomConstraint = buttonsContainerView.bottomAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.bottomAnchor
        )
        buttonsContainerBottomConstraint?.isActive = true
    }
    
    private func setupSubviews() {
        timerView.setData("00:00")
        investmentView.setData("100")
        updateCurrency(with: BalanceManager.shared.lastCurrencyPair)
        updateBalance()
    }
    
    private func updateBalance() {
        balanceAmountLabel.attributedText = String(BalanceManager.shared.balance).attributed(font: .sfProTextBold(with: 16))
    }
    
    private func updateCurrency(with pair: String) {
        currencyButton.setAttributedTitle(pair.attributed(font: .sfProTextBold(with: 16)),
                                          for: .normal)
        currencyButton.setAttributedTitle(pair.attributed(font: .sfProTextBold(with: 16), color: .lightGray),
                                          for: .highlighted)
    }
    
    private func showAlertSuccess() {
        let alertController = UIAlertController(title: "success".localized, message: nil, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "ok".localized, style: .cancel, handler: nil)
        alertController.addAction(action)
        
        present(alertController, animated: true)
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func removeKeyBoardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc
    private func keyboardWillShow(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]
                               as? NSValue)?.cgRectValue {
            let bottomInset = keyboardSize.height
            buttonsContainerBottomConstraint?.constant = -bottomInset + (tabBarController?.tabBar.frame.height ?? 0)
            buttonsContainerView.backgroundColor = #colorLiteral(red: 0.1069878414, green: 0.122041367, blue: 0.1768921614, alpha: 1)
            
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc
    private func keyboardWillHide(_ notification: Notification) {
        buttonsContainerBottomConstraint?.constant = 0
        buttonsContainerView.backgroundColor = #colorLiteral(red: 0.0716451928, green: 0.08674214035, blue: 0.1622816324, alpha: 1)
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc
    private func currencyButtonTapped() {
        let currencyVC = CurrencyViewController()
        currencyVC.delegate = self
        currencyVC.setCurrency(BalanceManager.shared.lastCurrencyPair)
        navigationController?.isNavigationBarHidden = true
        navigationController?.pushViewController(currencyVC, animated: true)
    }
    
    @objc
    private func buyButtonTapped() {
        guard let investmentViewText = investmentView.getData(),
              let investmentAmount = Int(investmentViewText),
              let balance = Int(BalanceManager.shared.balance)
        else { return }
        BalanceManager.shared.balance = String(balance - investmentAmount)
        updateBalance()
        showAlertSuccess()
    }
    
    @objc
    private func sellButtonTapped() {
        guard let investmentViewText = investmentView.getData(),
              let investmentAmount = Int(investmentViewText),
              let balance = Int(BalanceManager.shared.balance)
        else { return }
        BalanceManager.shared.balance = String(balance + investmentAmount)
        updateBalance()
        showAlertSuccess()
    }
}

extension TradeViewController: CurrencyViewControllerProtocol {
    func choseCurrency(pair: String) {
        BalanceManager.shared.lastCurrencyPair = pair
        updateCurrency(with: pair)
        chartView.loadChart(for: BalanceManager.shared.lastCurrencyPair)
    }
}
