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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        web.isGestureForworkBack = true
        web.isIndicator = true
        web.loadWeb(url: "https://m.daum.net")
    }


}

