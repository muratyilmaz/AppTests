//
//  FirebaseViewController.swift
//  AppLabs
//
//  Created by test on 09/01/2018.
//  Copyright © 2018 Grey. All rights reserved.
//

import UIKit
import Firebase
import Crashlytics

class FirebaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func logEvent(_ sender: Any) {
        /*Analytics.logEvent("click", parameters: [
            "name": "murti",
            "full_text": "hello space"
        ])*/
        
        Crashlytics.sharedInstance().crash()
    }

}
