//
//  NotificaitonHandler.swift
//  Notification10Demo
//
//  Created by Andrew on 2016/10/11.
//  Copyright © 2016年 Andrew. All rights reserved.
//

import UIKit
import  UserNotifications

enum UserNotificationType: String {
    case timeInterval
    case timeIntervalForeground
    case pendingRemoval
    case pendingUpdate
    case deliveredRemoval
    case deliveredUpdate
    case actionable
    case mutableContent
    case media
    case customUI
}

enum UserNoficationCategoryType:String{
    case saySomething
    case customUI
}

enum SaySomethingCategoryAction:String{
    case input
    case goodbye
    case none
}

enum CustomizeUICategoryAction: String {
    case switchOpen
    case open
    case dismiss
}


class NotificaitonHandler: NSObject,UNUserNotificationCenterDelegate {

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("收到通知了")
        
        if let name = response.notification.request.content.userInfo["name"] as? String {
            print("I know it's you! \(name)")
        }
       
        
        if let category = UserNoficationCategoryType(rawValue: response.notification.request.content.categoryIdentifier){
            switch category {
            case .saySomething:
                handleSaySomething(response: response)
                break
            case .customUI:
                handleCustomUI(response: response)
                break
            }
        }
        
        completionHandler()
        
    }
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        
        guard let notificationType = UserNotificationType(rawValue: notification.request.identifier) else {
            completionHandler([])
            return
        }
        
        completionHandler([.alert,.sound])
    }
    
    
    //MARK: - 私有方法
    private func handleSaySomething(response:UNNotificationResponse){
        let text:String
        
        if let actionType = SaySomethingCategoryAction(rawValue: response.actionIdentifier){
            switch actionType {
            case .input:text = (response as! UNTextInputNotificationResponse).userText
            case .goodbye:text = "Goodbye"
            case .none:text = ""
          
            }
        }else{
         //点击消失通知
            text = ""
        }
        
        if !text.isEmpty {
          UIAlertController.showAlert(message: "You just said \(text)")
        }
    }
    
    private func handleCustomUI(response:UNNotificationResponse)  {
        print(response.actionIdentifier)
    }
    
    
    
    
}
