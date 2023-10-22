//
//  ChartWebView.swift
//  TradingTestApp
//
//  Created by Дмитрий Мартынов on 22.10.2023.
//

import UIKit
import WebKit

class ChartWebView: UIView {
    private var htmlString = ""
    private var webView: WKWebView?
    private lazy var activityIndicator = UIActivityIndicatorView(style: .large)
    private var lastCurrencyPair: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        activityIndicator.color = #colorLiteral(red: 0.2057933807, green: 0.7238125801, blue: 0.4457931519, alpha: 1)
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func loadChart(for currency: String) {
        guard currency != lastCurrencyPair else { return }
        lastCurrencyPair = currency
        
        if let existingWebView = webView {
            existingWebView.removeFromSuperview()
        }
        
        webView = WKWebView(frame: bounds)
        webView?.scrollView.isScrollEnabled = false
        webView?.navigationDelegate = self
        guard let webView = webView else { return }
        
        webView.subviews.forEach { view in
            view.backgroundColor = .clear
        }
        
        addSubview(webView)
        addSubview(activityIndicator)
        activityIndicator.center = webView.center
        updateHtml(with: currency)
        webView.loadHTMLString(htmlString, baseURL: nil)
    }
    
    private func updateHtml(with currencyPair: String) {
        let currencyPair = currencyPair.replacingOccurrences(of: " / ", with: "")
        
        htmlString = """
    <!-- TradingView Widget BEGIN -->
    <div class="tradingview-widget-container" style="height:100%;width:100%">
      <div id="tradingview_097c0" style="height:calc(100% + 24px);width:calc(100% + 18px);margin-top: -10px;margin-left: -8px;"></div>
      <style>
        .tradingview-widget-copyright {
          display: none;
        }
      </style>
      <script type="text/javascript" src="https://s3.tradingview.com/tv.js"></script>
      <script type="text/javascript">
        new TradingView.widget(
        {
        "autosize": true,
        "symbol": "OANDA:\(currencyPair)",
        "interval": "3",
        "timezone": "exchange",
        "theme": "dark",
        "style": "1",
        "locale": "en",
        "enable_publishing": false,
        "hide_top_toolbar": true,
        "hide_legend": true,
        "save_image": false,
        "hide_volume": true,
        "container_id": "tradingview_097c0"
      }
        );
      </script>
    </div>
    <!-- TradingView Widget END -->
    """
    }
}

extension ChartWebView: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }
}
