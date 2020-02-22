//
//  ViewController.swift
//  THWebview
//
//  Created by TAEHUN YU on 22/10/2019.
//  Copyright © 2019 yutaehun. All rights reserved.
//

import UIKit
import THWebview

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
    }


}

