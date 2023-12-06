//
//  ViewController.swift
//  Finger Tap Game
//
//  Created by Tharin Zaman on 20/11/2023.
//

import UIKit

class FirstScreenViewController: UIViewController {
    
    let notificationHandler = NotificationHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notificationHandler.checkForPermissions()
    }

}

