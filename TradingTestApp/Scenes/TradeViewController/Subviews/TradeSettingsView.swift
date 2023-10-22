//
//  TradeSettingsView.swift
//  TradingTestApp
//
//  Created by Дмитрий Мартынов on 19.10.2023.
//

import UIKit

enum TradeSettingsType: String {
    case timer = "timer"
    case investment = "investment"
}

final class TradeSettingsView: UIView {
    private let type: TradeSettingsType
    
    // MARK: - Subviews
    private lazy var settingsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let textColor = #colorLiteral(red: 0.7843136787, green: 0.7843136787, blue: 0.7843136787, alpha: 1)
        label.attributedText = type.rawValue.localized.attributed(font: .interMedium(with: 12),
                                                                  color: textColor)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var minusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = #colorLiteral(red: 0.2011670172, green: 0.216167599, blue: 0.2881160975, alpha: 1)
        button.layer.cornerRadius = 12
        let image = #imageLiteral(resourceName: "minus")
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var plusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = #colorLiteral(red: 0.2011670172, green: 0.216167599, blue: 0.2881160975, alpha: 1)
        button.layer.cornerRadius = 12
        let image = #imageLiteral(resourceName: "plus")
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .none
        textField.keyboardType = .numberPad
        return textField
    }()
    
    init(type: TradeSettingsType) {
        self.type = type
        super.init(frame: .zero)
        
        backgroundColor = #colorLiteral(red: 0.2011670172, green: 0.216167599, blue: 0.2881160975, alpha: 1)
        layer.cornerRadius = 12
        clipsToBounds = true
        layer.borderColor = #colorLiteral(red: 0.2113476098, green: 0.7277538776, blue: 0.4497774243, alpha: 1)
        textField.delegate = self
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func setData(_ text: String) {
        textField.attributedText = text.attributed(font: .sfProTextBold(with: 16))
    }
    
    func getData() -> String? {
        textField.text
    }
    
    // MARK: - Private methods
    private func setup() {
        addSubview(settingsLabel)
        addSubview(textField)
        addSubview(minusButton)
        addSubview(plusButton)
        
        NSLayoutConstraint.activate([
            settingsLabel.bottomAnchor.constraint(equalTo: topAnchor, constant: 20),
            settingsLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            settingsLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            settingsLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            textField.centerXAnchor.constraint(equalTo: centerXAnchor),
            textField.centerYAnchor.constraint(equalTo: minusButton.centerYAnchor),
            
            minusButton.topAnchor.constraint(equalTo: centerYAnchor, constant: -2),
            minusButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            
            plusButton.topAnchor.constraint(equalTo: centerYAnchor, constant: -2),
            plusButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])
    }
    
    private func animateTap() {
        let animation = CABasicAnimation(keyPath: "borderWidth")
        animation.fromValue = 1
        animation.toValue = 0
        animation.duration = 1.0
        layer.borderWidth = 0
        layer.add(animation, forKey: "borderWidth")
    }
    
    @objc
    private func minusButtonTapped() {
        guard let text = textField.text else { return }
        switch type {
        case .timer:
            guard let minutesString = textField.text?.components(separatedBy: ":").first,
                  let secondsString = textField.text?.components(separatedBy: ":").last,
                  let minutes = Int(minutesString),
                  let seconds = Int(secondsString)
            else { return }
            
            var newMinutes: Int = minutes
            var newSeconds: Int = seconds
            
            guard !(newSeconds == 0 && newMinutes == 0) else { return }
            if newSeconds != 0 {
                newSeconds -= 1
            } else {
                newSeconds = 59
                newMinutes -= 1
            }
            
            var updatedMinutes = String(newMinutes)
            var updatedSeconds = String(newSeconds)
            
            if newMinutes < 10 {
                updatedMinutes = "0\(updatedMinutes)"
            }
            
            if newSeconds < 10 {
                updatedSeconds = "0\(updatedSeconds)"
            }
            
            textField.attributedText = (updatedMinutes + ":" + updatedSeconds).attributed(font: .sfProTextBold(with: 16))
        case .investment:
            let newValue = 100 * Int(((Double(text) ?? 0) / 100.0).rounded()) - 100
            let newValueString = newValue > 0 ? String(newValue) : String(0)
            
            textField.attributedText = newValueString.attributed(font: .sfProTextBold(with: 16))
        }
        animateTap()
    }
    
    @objc
    private func plusButtonTapped() {
        guard let text = textField.text else { return }
        switch type {
        case .timer:
            guard let minutesString = textField.text?.components(separatedBy: ":").first,
                  let secondsString = textField.text?.components(separatedBy: ":").last,
                  let minutes = Int(minutesString),
                  let seconds = Int(secondsString)
            else { return }
            
            var newMinutes: Int = minutes
            var newSeconds: Int = seconds
            
            if newSeconds < 59 {
                newSeconds += 1
            } else {
                newSeconds = 0
                newMinutes += 1
            }
            
            var updatedMinutes = String(newMinutes)
            var updatedSeconds = String(newSeconds)
            
            if newMinutes < 10 {
                updatedMinutes = "0\(updatedMinutes)"
            }
            
            if newSeconds < 10 {
                updatedSeconds = "0\(updatedSeconds)"
            }
            
            textField.attributedText = (updatedMinutes + ":" + updatedSeconds).attributed(font: .sfProTextBold(with: 16))
        case .investment:
            textField.attributedText = String(100 * Int(((Double(text) ?? 0) / 100.0).rounded()) + 100).attributed(font: .sfProTextBold(with: 16))
        }
        animateTap()
    }
}

extension TradeSettingsView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if type == .timer {
            textField.text = ""
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            self.layer.borderWidth = 1
        })
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if type == .timer {
            if textField.text?.count != 5 {
                textField.text = "00:00"
            }
        } else {
            if let text = textField.text,
               let investment = Int(text),
               investment > 0 {
                textField.text = String(text.drop(while: { $0 == "0" }))
            } else {
                textField.text = "0"
            }
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            self.layer.borderWidth = 0
        })
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch type {
        case .timer:
            if let invertedCharacterSet = NSCharacterSet.decimalDigits.inverted as CharacterSet? {
                if string.rangeOfCharacter(from: invertedCharacterSet) != nil {
                    return false
                } else {
                    let text = textField.text ?? ""
                    let length = text.count
                    var shouldReplace = true
                    
                    if !string.isEmpty {
                        switch length {
                        case 2:
                            if let text = textField.text,
                                let sec = Int(text),
                            sec > 59 {
                                shouldReplace = false
                                textField.text = "01:"
                            } else {
                                textField.text = text + ":"
                            }
                        case 4:
                            if let minText = textField.text?.components(separatedBy: ":").first,
                               let secText = textField.text?.components(separatedBy: ":").last,
                               let tensSec = Int(secText),
                               tensSec > 5 {
                                shouldReplace = false
                                textField.text = minText + ":59"
                            }
                        default:
                            break
                        }
                        if length > 4 {
                            shouldReplace = false
                        }
                    }
                    
                    return shouldReplace
                }
            }
            return true
        case .investment:
            return true
        }
    }
}
