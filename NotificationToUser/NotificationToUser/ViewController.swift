//
//  ViewController.swift
//  NotificationToUser
//
//  Created by abdullah on 21/11/1441 AH.
//  Copyright © 1441 abdullah. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var SandButtonOutlet: UIButton!
    var _notificationView: NotificationViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SandButtonOutlet.layer.cornerRadius = 12
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let storyboard = UIStoryboard(name: Bundle.main.infoDictionary?["UIMainStoryboardFile"] as! String, bundle: Bundle.main)
        _notificationView = storyboard.instantiateViewController(withIdentifier: "NotificationViewController") as? NotificationViewController
        _notificationView?.addSubViewAtWindow()
    }
    
    @IBAction func callNotificationButtonTouch(_ sender: Any) {
        
        NotificationCenter.default.post(name: NSNotification.Name.init("app_notification"), object: nil)
    }
}

