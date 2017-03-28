//
//  TermsOfUseViewController.swift
//  KodakVer3
//
//  Created by SQA on 28/03/2017.
//  Copyright © 2017 jmolas. All rights reserved.
//

import UIKit

class TermsOfUseViewController: UIViewController {

    @IBOutlet weak var myScroll: UIScrollView!
    
    override func viewWillAppear(_ animated: Bool) {
        let navTransition = CATransition()
        navTransition.duration = 1
        navTransition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        navTransition.type = kCATransitionPush
        navTransition.subtype = kCATransitionPush
        self.navigationController?.navigationBar.layer.add(navTransition, forKey: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        myScroll .flashScrollIndicators()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        myScroll .flashScrollIndicators()
        self.myScroll.showsVerticalScrollIndicator = true
    }
    
}
