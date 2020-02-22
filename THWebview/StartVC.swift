//
//  StartVC.swift
//  THWebview
//
//  Created by TAEHUN YU on 22/02/2020.
//  Copyright © 2020 yutaehun. All rights reserved.
//

import UIKit

class StartVC: UIViewController {
    
    @IBOutlet weak var valueIndicator: UISwitch!
    @IBOutlet weak var valueGestureBack: UISwitch!
    
    @IBAction func touchNaver(_ sender: UIButton) {
        openView(url: "https://m.naver.com")
    }
    
    @IBAction func touchDaum(_ sender: UIButton) {
        openView(url: "https://m.daum.net")
    }
    
    @IBAction func touchYoutube(_ sender: UIButton) {
        openView(url: "https://m.youtube.com")
    }
    
    func openView(url: String) {
        let target = UIStoryboard(name: "Main", bundle: nil)
        let vc = target.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        
        vc.indicator = valueIndicator.isOn
        vc.gestureBack = valueGestureBack.isOn
        vc.url = url
        
        self.present(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

