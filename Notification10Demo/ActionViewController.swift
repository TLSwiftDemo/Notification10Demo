//
//  ActionViewController.swift
//  Notification10Demo
//
//  Created by Andrew on 2016/10/12.
//  Copyright © 2016年 Andrew. All rights reserved.
//

import UIKit
import  UserNotifications

class ActionViewController: UIViewController {
    var notificationIdentity:UserNotificationType!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "Action Notificaiton"
        // Do any additional setup after loading the view.
        initView()
    }
    
    func initView() -> Void {
        let btn = UIButton(frame: CGRect(x: 0, y: 100, width: screenWIdth, height: 50))
        btn.setTitle("点击发送通知", for:.normal)
        btn.setTitleColor(UIColor.red, for: .normal)
        self.view.addSubview(btn)
        
        btn.addTarget(self, action: #selector(tapMe(btn:)), for: .touchUpInside)
    }

   
    func tapMe(btn:UIButton) -> Void {
        let content = UNMutableNotificationContent()
        content.body = "Please say something"
        content.categoryIdentifier  = UserNoficationCategoryType.saySomething.rawValue
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: UserNotificationType.actionable.rawValue, content: content, trigger: trigger)
        
        
       
    
  
        
        UNUserNotificationCenter.current().add(request)
        
        
    }

}
