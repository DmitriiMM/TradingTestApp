//
//  TabBarController.swift
//  TradingTestApp
//
//  Created by Дмитрий Мартынов on 18.10.2023.
//

import UIKit

final class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeViewControllers()
        setup()
    }
    
    private func makeViewControllers() {
        let tradeViewController = TradeViewController()
        let tradeNavigationController = UINavigationController(rootViewController: tradeViewController)
        
        let topViewController = TopViewController()
        let topNavigationController = UINavigationController(rootViewController: topViewController)
       
        viewControllers = [tradeNavigationController, topNavigationController]
    }

    private func setup() {
        tabBar.backgroundImage = UIImage()
        tabBar.backgroundColor = #colorLiteral(red: 0.1236568466, green: 0.1336546838, blue: 0.1844462752, alpha: 1)
        tabBar.isTranslucent = false
        tabBar.shadowImage = UIImage()

        tabBar.tintColor = #colorLiteral(red: 0.2113476098, green: 0.7277538776, blue: 0.4497774243, alpha: 1)
        tabBar.unselectedItemTintColor = #colorLiteral(red: 0.4708875418, green: 0.4908440113, blue: 0.5588842034, alpha: 1)
        
        tabBar.items?[0].title = "trade".localized
        tabBar.items?[0].image = #imageLiteral(resourceName: "tradeIcon")
        tabBar.items?[0].selectedImage = #imageLiteral(resourceName: "tradeIconSelected")
        tabBar.items?[1].title = "top".localized
        tabBar.items?[1].image = #imageLiteral(resourceName: "topIcon")
        tabBar.items?[1].selectedImage = #imageLiteral(resourceName: "topIconSelected")
        
        let topBorder = CALayer()
        topBorder.frame = CGRect(x: 0, y: 0, width: tabBar.frame.size.width, height: 1)
        topBorder.backgroundColor = #colorLiteral(red: 0.1815508604, green: 0.1965581775, blue: 0.2558284402, alpha: 1)
        tabBar.layer.addSublayer(topBorder)
    }
}


