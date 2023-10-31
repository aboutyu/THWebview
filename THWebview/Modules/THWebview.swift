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

public enum THWebViewAction {
    case started(_ navigation: WKNavigation?)
    case finished(_ navigation: WKNavigation?)
    case failed(_ error: Error)
    case closed
}

public class THWebview: UIView, WKNavigationDelegate, WKUIDelegate {
    
    private let webView = WKWebView()
    private let indicator = UIActivityIndicatorView()
    
    // Setting Values
    open var isIndicator: Bool = false
    open var isGestureForworkBack: Bool = false
    public var action: ((THWebViewAction) -> ())? = nil
    public var decisionHandler: ((URL, WKNavigationAction) -> ())? = nil
    
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
    
    private func setAction(type: THWebViewAction, navigation: WKNavigation? = nil, error: Error? = nil) {
        guard let action = action  else { return }
        action(type)
    }
}

//-Mark: Initialize WKNavigationDelegate
extension THWebview {
    
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard let url = navigationAction.request.url else {
            decisionHandler(.allow)
            return
        }
        
        if ["tel"].contains(url.scheme) {
            UIApplication.shared.open(url, options: [:])
            decisionHandler(.cancel)
            return
        }
        
        if ["kakaokompassauth", "kakaolink", "kakaoplus"].contains(url.scheme) && UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            decisionHandler(.cancel)
            return
        }
        
        if let handler = self.decisionHandler {
            handler(url, navigationAction)
        }
        decisionHandler(.allow)
    }
    
    public func webViewDidClose(_ webView: WKWebView) {
        setAction(type: .closed)
    }
    
    //-Mark: Delegate when start loading webpage
    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        loadingIndicator(action: true)
        setAction(type: .started(navigation))
    }
    
    //-Mark: Delegate when finish loading webpage
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loadingIndicator(action: false)
        setAction(type: .finished(navigation))
    }
    
    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        loadingIndicator(action: false)
        setAction(type: .failed(error))
    }
    
    public func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        loadingIndicator(action: false)
        setAction(type: .failed(error))
    }
    
    public func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        loadingIndicator(action: false)
    }
    
    public func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        loadingIndicator(action: false)
    }
    
    public func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        loadingIndicator(action: false)
    }
}

//-Mark: Initialize Views
extension THWebview {
    
    // Init WebView
    private func initWebview() {
        self.addSubview(webView)
        
        self.webView.uiDelegate = self
        self.webView.navigationDelegate = self
        self.webView.translatesAutoresizingMaskIntoConstraints = false
        
        self.webView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.webView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.webView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.webView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
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
