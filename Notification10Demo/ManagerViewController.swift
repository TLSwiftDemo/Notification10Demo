//
//  ManagerViewController.swift
//  Notification10Demo
//
//  Created by Andrew on 2016/10/12.
//  Copyright © 2016年 Andrew. All rights reserved.
//

import UIKit
import  UserNotifications

class ManagerViewController: UIViewController {
    var notificationIdentity:UserNotificationType!
    
    let notification1:UNNotificationContent = {
        let content = UNMutableNotificationContent()
        content.title = "1"
        content.body = "Notificaiton1"
        return content
    }()
    
    let notificaiton2:UNNotificationContent = {
        let content = UNMutableNotificationContent()
        content.title = "2"
        content.body = "Notificaiton2"
        return content
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "Manager Notificaiton"
        // Do any additional setup after loading the view.
        initView()
    }
    
    func initView() -> Void
    {
        
        var rect = CGRect(x: 0, y: 100, width: screenWIdth, height: 50)
        let btn1 = createBtn(rect: rect, title: "删除将要发送的通知")
        btn1.addTarget(self, action: #selector(pendingRemove(btn:)), for: .touchUpInside)
        self.view.addSubview(btn1)
        
        rect = CGRect(x: 0, y: btn1.frame.maxY+10, width: screenWIdth, height: 50)
        let btn2 = createBtn(rect: rect, title: "更新将要发送的通知")
        btn2.addTarget(self, action: #selector(pendingUpdate(btn:)), for: .touchUpInside)
        self.view.addSubview(btn2)
        
        rect = CGRect(x: 0, y: btn2.frame.maxY+10, width: screenWIdth, height: 50)
        let btn3 = createBtn(rect: rect, title: "删除已经发送的通知")
        btn3.addTarget(self, action: #selector(deliveredRemove(btn:)), for: .touchUpInside)
        self.view.addSubview(btn3)
        
        rect = CGRect(x: 0, y: btn3.frame.maxY+10, width: screenWIdth, height: 50)
        let btn4 = createBtn(rect: rect, title: "更新已经发送的通知")
        btn4.addTarget(self, action: #selector(deliveredUpdate(btn:)), for: .touchUpInside)
        self.view.addSubview(btn4)
     
        
    }
    
    func createBtn(rect:CGRect,title:String) -> UIButton {
        let btn = UIButton(frame: rect)
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(UIColor.red, for: .normal)
        return btn
    }

    
    //移除将要发送的消息
    func pendingRemove(btn:UIButton) -> Void {
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        let identifier = UserNotificationType.pendingRemoval.rawValue
        
        let request = UNNotificationRequest(identifier: identifier, content: notification1, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
             UIAlertController.showAlert(message: error.localizedDescription)
            }else{
                print("Notification request added :\(identifier)")
            }
        }
        
        
        delay(time: 2) {
            print("Notificaiton request removed :\(identifier)")
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier])
        }
    }
    //更新将要发送的消息
    func pendingUpdate(btn:UIButton) -> Void {
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        let identity = UserNotificationType.pendingUpdate.rawValue
        let request = UNNotificationRequest(identifier: identity, content: notification1, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
             UIAlertController.showAlert(message: error.localizedDescription)
            }else{
              print("Notification request added :\(identity)")
            }
        }
        
        delay(time: 2) { 
            let newTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
            let newRequest = UNNotificationRequest(identifier: identity, content: self.notificaiton2, trigger: newTrigger)
            UNUserNotificationCenter.current().add(newRequest, withCompletionHandler: { (error) in
                if let error = error {
                 UIAlertController.showAlert(message: error.localizedDescription)
                }else{
                 print("Notification request updated:\(identity) with notification2")
                }
            })
        }
    }
    
    
    //删除已经发送的消息
    func deliveredRemove(btn:UIButton) -> Void {
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        let identity = UserNotificationType.deliveredRemoval.rawValue
        let request = UNNotificationRequest(identifier: identity, content: notification1, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
              UIAlertController.showAlert(message: error.localizedDescription)
            }else{
              print("Notificaiton request added :\(identity)")
            }
        }
        
        delay(time: 4) {
            print("Notificaiton request removed :\(identity)")
            UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [identity])
        }
    }
    
    //更新已经发送的消息
    func deliveredUpdate(btn:UIButton) -> Void {
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        let identity = UserNotificationType.deliveredUpdate.rawValue
        
        let request = UNNotificationRequest(identifier: identity, content: notification1, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
              UIAlertController.showAlert(message: error.localizedDescription)
            }
            else{
             print("Notification reuqest added :\(identity) with notification1")
            }
        }
        
        delay(time: 4) { 
            let newTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
            let newRequeset = UNNotificationRequest(identifier: identity, content: self.notificaiton2, trigger: newTrigger)
            UNUserNotificationCenter.current().add(newRequeset, withCompletionHandler: { (error) in
                if let error = error {
                    UIAlertController.showAlert(message: error.localizedDescription)
                }else{
                print("Notifcation request updated :\(identity) with notification2")
                }
            })
        }
    }

}
