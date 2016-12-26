//
//  TimeIntervalController.swift
//  Notification10Demo
//
//  Created by Andrew on 2016/10/12.
//  Copyright © 2016年 Andrew. All rights reserved.
//

import UIKit
import  UserNotifications




class TimeIntervalController: UIViewController {
    
    var notificationIdentity:UserNotificationType!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "TIme interval Notification"
        // Do any additional setup after loading the view.
        
        
        initView()
    }
    
    func initView() -> Void {
        let btn = UIButton(frame: CGRect(x: 0, y: 100, width: screenWIdth, height: 50))
        btn.setTitle("点击发送通知", for:.normal)
        btn.setTitleColor(UIColor.red, for: .normal)
        self.view.addSubview(btn)
        
        btn.addTarget(self, action: #selector(createNotificaiton), for: .touchUpInside)
    }

  
    func createNotificaiton() -> Void {
        //创建通知内容
        let content = UNMutableNotificationContent()
        content.title = "Time interval Notifications"
        content.body = "你好 iOS Notificaiton"
        content.userInfo = ["name":"安路"]
        //创建发送触发
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        
        //发送请求标识
        let requestIdentity = notificationIdentity.rawValue
        
        //创建一个发送请求
        let request = UNNotificationRequest(identifier: requestIdentity, content: content, trigger: trigger)
        
        //将请求添加到发送中心
        UNUserNotificationCenter.current().add(request) { error in
            if error == nil{
                print("Time interval Notifications scheduled:\(requestIdentity)")
            }
        }
        
    }

}
