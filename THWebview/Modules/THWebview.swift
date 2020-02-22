//
//  THWebview.swift
//  THWebview
//
//  Created by James Yu on 22/10/2019.
//  Copyright © 2019 james. All rights reserved.
//  Version 1.0.2.

import Foundation
import UIKit
import WebKit

public class THWebview: UIView, WKNavigationDelegate, WKUIDelegate {
    
    private let webView = WKWebView()
    private let indicator = UIActivityIndicatorView()
    
    // Setting Values
    open var isIndicator: Bool = false
    open var isGestureForworkBack: Bool = false
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        initWebview()
        initIndicator()
        initSwipe()
    }
    
    open func loadWeb(url: String) {
        guard let request = convertUrl(str: url) else {
            return
        }
        webView.load(request)
    }
    
    
    //-Mark: Convert type String to URLRequest
    private func convertUrl(str: String) -> URLRequest? {
        guard let url = URL(string: str) else {
            return nil
        }
        
        let request = URLRequest(url: url)
        return request
    }
    
    //-Mark: Show Indicator
    private func loadingIndicator(action: Bool) {
        
        if isIndicator == true {
            
            if action == true {
                indicator.startAnimating()
                indicator.isHidden = false
            } else {
                indicator.stopAnimating()
                indicator.isHidden = true
            }
        }
    }
}

//-Mark: Initialize WKNavigationDelegate
extension THWebview {
    
    //-Mark: Delegate when start loading webpage
    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        loadingIndicator(action: true)
    }
    
    //-Mark: Delegate when finish loading webpage
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loadingIndicator(action: false)
    }
    
    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        loadingIndicator(action: false)
//        print("if error:", error.localizedDescription)
    }
}

//-Mark: Initialize Views
extension THWebview {
    
    // Init WebView
    private func initWebview() {
        webView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        self.addSubview(webView)
        
        webView.uiDelegate = self
        webView.navigationDelegate = self
    }
    
    // Init Indicator
    private func initIndicator() {
        indicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        indicator.center = self.center
        self.addSubview(indicator)
        self.bringSubviewToFront(indicator)
    }
}

//-Mark: Initialize Swipe
extension THWebview {
    
    private func initSwipe() {

        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeLeft.direction = .left
        webView.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeRight.direction = .right
        webView.addGestureRecognizer(swipeRight)
    }

    @objc private func handleSwipe(_ recognizer: UISwipeGestureRecognizer) {
        let recog = recognizer.direction
        
        if isGestureForworkBack == true &&
            recog == .left &&
            webView.canGoForward {
            
            webView.goForward()
        }

        if isGestureForworkBack == true &&
            recog == .right &&
            webView.canGoBack {
            
            webView.goBack()
        }
    }
}
