//
//  NotificationViewController.swift
//  NotificationToUser
//
//  Created by abdullah on 21/11/1441 AH.
//  Copyright © 1441 abdullah. All rights reserved.
//

import UIKit
import AudioToolbox

class NotificationViewController: UIViewController {
    
    @IBOutlet weak var LabelText: UILabel!
    @IBOutlet weak var _notificationViewConstraintTop: NSLayoutConstraint!
    @IBOutlet weak var _notificationView: UIView!
    
    var _notificationTopViewTop: NSLayoutConstraint?
    var _timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LabelText.text = "للمزيد تابعني على حسابي في تويتر 980bd@"
    }
    
        
    func addSubViewAtWindow() {
        
        
        self.view.translatesAutoresizingMaskIntoConstraints = false
        
        
        _notificationView.layer.cornerRadius = 5
        _notificationView.clipsToBounds = true
        
        
        _notificationView.layer.borderColor = UIColor.black.cgColor
        _notificationView.layer.borderWidth = 0.5
        
        
        _notificationView.alpha = 0
        _notificationViewConstraintTop.constant = -109
        
        
        let window: UIWindow? = UIApplication.shared.windows.first { $0.isKeyWindow }
        window?.addSubview(self.view)
        
        
        _notificationTopViewTop = NSLayoutConstraint.init(item: self.view!,
                                                          attribute: .top,
                                                          relatedBy: .equal,
                                                          toItem: window!,
                                                          attribute: .top,
                                                          multiplier: 1,
                                                          constant: -109)
        
        window?.addConstraint(_notificationTopViewTop!)
        
        window?.addConstraint(NSLayoutConstraint.init(item: self.view!,
                                                      attribute: .left,
                                                      relatedBy: .equal,
                                                      toItem: window!,
                                                      attribute: .left,
                                                      multiplier: 1,
                                                      constant: 0))
        
        window?.addConstraint(NSLayoutConstraint.init(item: self.view!,
                                                      attribute: .right,
                                                      relatedBy: .equal,
                                                      toItem: window!,
                                                      attribute: .right,
                                                      multiplier: 1,
                                                      constant: 0))
        
        
        self.view?.addConstraint(NSLayoutConstraint.init(item: self.view!,
                                                         attribute: .height,
                                                         relatedBy: .equal,
                                                         toItem: nil,
                                                         attribute: .height,
                                                         multiplier: 1,
                                                         constant: 109))
        
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(appNotification(aNotification:)),
                                               name: NSNotification.Name.init("app_notification"),
                                               object: nil)
        
    }
    
    
    @objc func appNotification(aNotification: NSNotification) {
        
        
        if #available(iOS 10,*) {
            generator(type: 2)
        } else {
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        }
        
        
        if _timer != nil {
            _timer?.invalidate()
            _timer = nil
        }
        
        
        _timer = Timer.scheduledTimer(timeInterval: 3,
                                      target: self,
                                      selector: #selector(appNotificationClose(aTimer:)),
                                      userInfo: nil,
                                      repeats: false)
        
        
        _notificationTopViewTop?.constant = 0
        _notificationViewConstraintTop.constant = 0
        
        UIView.animate(withDuration: 0.25) {
            self._notificationView.alpha = 1
            self.view.layoutIfNeeded()
        }
    }
    
    
    @objc func appNotificationClose(aTimer: Timer) {
        
        self._notificationViewConstraintTop.constant = -109
        
        UIView.animate(withDuration: 0.25,
                       animations: {
                        self._notificationView.alpha = 0
                        self.view.layoutIfNeeded()
        }) { (completion: Bool) in
            self._notificationTopViewTop?.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    
    func generator(type: Int) {
        
        switch type {
        case 1:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
        case 2:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.warning)
        case 3:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
        case 4:
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
        case 5:
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
        case 6:
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()
        default:
            let generator = UISelectionFeedbackGenerator()
            generator.selectionChanged()
        }
    }
}
