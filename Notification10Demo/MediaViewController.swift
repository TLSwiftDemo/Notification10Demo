//
//  MediaViewController.swift
//  Notification10Demo
//
//  Created by Andrew on 2016/10/12.
//  Copyright © 2016年 Andrew. All rights reserved.
//

import UIKit
import UserNotifications

class MediaViewController: UIViewController {
    var notificationIdentity:UserNotificationType!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "Media Notificaiton"
        // Do any additional setup after loading the view.
        initView()
    }
    
    func initView() -> Void {
        let btn = UIButton(frame: CGRect(x: 0, y: 100, width: screenWIdth, height: 50))
        btn.setTitle("点击发送通知", for:.normal)
        btn.setTitleColor(UIColor.red, for: .normal)
        self.view.addSubview(btn)
        
        btn.addTarget(self, action: #selector(mediaNotification(btn:)), for: .touchUpInside)
    }


    
    func mediaNotification(btn:UIButton) -> Void {
        let content = UNMutableNotificationContent()
        content.title = "Image Notification"
        content.body = "Show me an Image"
        
        if let imageUrl = Bundle.main.url(forResource: "testImg", withExtension: "png"),
            let attachment = try?UNNotificationAttachment(identifier: "imageAttachment", url: imageUrl, options: nil)
        {
         content.attachments = [attachment]
        }
        
        //创建一个触发器，决定什么时机发送通知
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        let requestIdentity = UserNotificationType.media.rawValue
        
        let request = UNNotificationRequest(identifier: requestIdentity, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
             UIAlertController.showAlert(message: error.localizedDescription)
            }else{
             print("Media Notificaiton alreaded scheduled:\(requestIdentity)")
            }
        }
        
    }
  

}
