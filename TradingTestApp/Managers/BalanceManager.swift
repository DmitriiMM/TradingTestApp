//
//  BalanceManager.swift
//  TradingTestApp
//
//  Created by Дмитрий Мартынов on 21.10.2023.
//

import Foundation

/// Хранит баланс пользователя и выбранную последней валютную пару
class BalanceManager {
    static let shared = BalanceManager()
    private let userDefaults = UserDefaults.standard
    
    private enum Keys: String {
        case balance = "balance"
        case lastCurrencyPair = "lastCurrencyPair"
    }
    
    var balance: String {
        get {
            userDefaults.string(forKey: Keys.balance.rawValue) ?? "10000"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.balance.rawValue)
        }
    }
    
    var lastCurrencyPair: String {
        get {
            userDefaults.string(forKey: Keys.lastCurrencyPair.rawValue) ?? "EUR / USD"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.lastCurrencyPair.rawValue)
        }
    }
}
