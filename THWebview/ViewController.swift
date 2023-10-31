//
//  ViewController.swift
//  THWebview
//
//  Created by TAEHUN YU on 22/10/2019.
//  Copyright © 2019 yutaehun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var web: THWebview!
    
    var indicator: Bool         = false
    var gestureBack: Bool       = false
    var url: String             = "https://m.google.com"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        web.isIndicator = indicator
        web.isGestureForworkBack = gestureBack
        web.loadWeb(url: url)
        
        web.action = { [weak self] (action) in
            guard let self = self else { return }
            
            print("action url:", action)
            switch action {
            case .started(let navigation): 
                print("action naviagtion:", navigation)
                break
            case .finished(let navigation): 
                print("action naviagtion:", navigation)
                break
            case .failed(let error): 
                print("action error:", error)
                break
            case .closed: 
                break
            }
        }
        
        web.decisionHandler = { [weak self] (url, navigation) in
            guard let self = self else { return }
            print("decisionHandler url:", url)
            print("decisionHandler naviagtion:", navigation)
        }
    }


}

