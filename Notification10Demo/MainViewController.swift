//
//  MainViewController.swift
//  Notification10Demo
//
//  Created by Andrew on 2016/10/12.
//  Copyright © 2016年 Andrew. All rights reserved.
//

import UIKit
import UserNotifications


class MainViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var arrayData = [String]()
    var tableView:UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white

        arrayData = ["Time Interval",
                     "Time Interval Foreground",
                     "Notificaiton Managerment",
                     "Action",
                     "Media Notificaiton",
                     "Custom UI"]
        initView()
        
        registerNotification()
    }
    
    func registerNotification() -> Void {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge,]) { (granted, error) in
            if granted {
              //允许用户发送通知
            }
        }
    }
    
    
    func initView() -> Void {
        let rect = CGRect(x: 0, y: 0, width: screenWIdth, height: screenHeight)
        tableView = UITableView(frame: rect)
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identity = "identity"
        var cell = tableView.dequeueReusableCell(withIdentifier: identity)
        if cell == nil{
           cell = UITableViewCell(style: .default, reuseIdentifier: identity)
        }
        
        cell?.textLabel?.text = arrayData[indexPath.row]
        cell?.accessoryType = .disclosureIndicator
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellTitle = arrayData[indexPath.row]
        
        var vc:UIViewController!
        switch cellTitle {
        case "Time Interval":
            vc = TimeIntervalController()
            (vc as! TimeIntervalController).notificationIdentity  = UserNotificationType.timeInterval
        case "Time Interval Foreground":
            vc = ForegroundViewController()
            (vc as! ForegroundViewController) .notificationIdentity = UserNotificationType.timeIntervalForeground
        case "Notificaiton Managerment":
            vc = ManagerViewController()
            (vc as! ManagerViewController).notificationIdentity = UserNotificationType.pendingUpdate
        case "Action":
            vc = ActionViewController()
            (vc as! ActionViewController).notificationIdentity = UserNotificationType.actionable
        case "Media Notificaiton":
            vc = MediaViewController()
            (vc as! MediaViewController).notificationIdentity = UserNotificationType.media
        case "Custom UI":
            vc = CustomUIViewController()
            (vc as! CustomUIViewController).notificationIdentity = UserNotificationType.customUI
            
        default:
            break
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }

}
