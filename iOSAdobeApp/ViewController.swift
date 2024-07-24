//
//  ViewController.swift
//  iOSAdobeApp
//
//  Created by Hana Park on 7/23/24.
//

import UIKit
import AdobeBranchExtension

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func pressedCustomEventButton(_ sender: UIButton) {
        MobileCore.track(
            action: "CUSTOM TEST EVENT",
            data: [
                "revenue": "5",
                "currency": "USD",
                "transaction_id": "12345-7890"
            ])
    }
    
    @IBAction func pressedStandardEventButton(_ sender: UIButton) {
        MobileCore.track(
            action: "PURCHASE",
             data: [
                 "revenue": "105",
                 "currency": "USD",
                 "transaction_id": "12345-7890"
             ])
    }
    
}

