//
//  CustomUIViewController.swift
//  Notification10Demo
//
//  Created by Andrew on 2016/10/12.
//  Copyright © 2016年 Andrew. All rights reserved.
//

import UIKit
import UserNotifications

class CustomUIViewController: UIViewController {
    var notificationIdentity:UserNotificationType!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white

        self.navigationItem.title = "CustomUI"
        
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
        let content = UNMutableNotificationContent()
        content.title = "custom UI Notification"
        content.body = "Show me some images"
        
        let imageNames = ["testImg","image1"]
        
        let attachments = imageNames.flatMap { name -> UNNotificationAttachment? in
            if let imageUrl = Bundle.main.url(forResource: name, withExtension: "png"){
            return try? UNNotificationAttachment(identifier: "image-\(name)", url: imageUrl, options: nil)
            }
            return nil
        }
       
        content.attachments = attachments
        content.userInfo = ["items": [["title": "Photo 1", "text": "Cute girl","image":"testImg"], ["title": "Photo 2", "text": "Cute cat","image":"image1"]]]
        //设置category
        content.categoryIdentifier = UserNoficationCategoryType.customUI.rawValue
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let requestIdentity = UserNotificationType.customUI.rawValue
        let request = UNNotificationRequest(identifier: requestIdentity, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
             UIAlertController.showAlert(message: error.localizedDescription)
            }else{
                print("CustomUI notification scheduled:\(requestIdentity)")
            }
        }
    }
    

  
}
