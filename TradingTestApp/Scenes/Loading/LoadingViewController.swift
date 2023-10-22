//
//  LoadingViewController.swift
//  TradingTestApp
//
//  Created by Дмитрий Мартынов on 21.10.2023.
//

import UIKit

final class LoadingViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var progressView: UIProgressView!
    @IBOutlet private weak var progressLabel: UILabel!
    
    var currentProgress: Float = 0.0
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        startLoading()
    }
    
    // MARK: - Private methods
    private func setup() {
        progressView.layer.cornerRadius = 12
        progressView.clipsToBounds = true
    }
    
    private func startLoading() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateProgress), userInfo: nil, repeats: true)
    }
    
    @objc
    private func updateProgress() {
        currentProgress += 0.01
        progressView.progress = currentProgress
        progressLabel.attributedText = "\(Int(currentProgress * 100))%".attributed(font: .interBold(with: 16))
        
        if currentProgress >= 1.0 {
            timer?.invalidate()
            timer = nil
            
            let blackView = UIView(frame: UIScreen.main.bounds)
            blackView.backgroundColor = .black.withAlphaComponent(0.3)
            view.addSubview(blackView)
            
            progressView.isHidden = true
            progressLabel.isHidden = true
            
            LocalNotificationsManager.shared.requestUserNotifications {
                DispatchQueue.main.async {
                    let tabBarVC = TabBarController()
                    tabBarVC.modalTransitionStyle = .crossDissolve
                    tabBarVC.modalPresentationStyle = .fullScreen
                    self.present(tabBarVC, animated: true)
                }
            }
        }
    }
}
