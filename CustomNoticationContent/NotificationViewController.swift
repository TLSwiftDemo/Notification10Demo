//
//  NotificationViewController.swift
//  CustomNoticationContent
//
//  Created by Andrew on 2016/10/11.
//  Copyright © 2016年 Andrew. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

struct NotificitonItem {
    let url:URL
    let title:String
    let text:String
}

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    @IBOutlet var label: UILabel?
    
    var items:[NotificitonItem] = []
    
    private var index:Int = 0
    
    var imageView:UIImageView!
    var lable:UILabel!
    var textView:UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    func initView() -> Void {
        var rect = CGRect(x: 0, y: 0, width: 100, height: 100)
        imageView = UIImageView(frame: rect)
        imageView.backgroundColor = UIColor.white
        self.view.addSubview(imageView)
        
        
        rect = CGRect(x:imageView.frame.maxX+10 , y: imageView.frame.origin.y+10, width: 200, height: 50)
        label = UILabel(frame: rect)
        self.view.addSubview(label!)
        
        rect = CGRect(x: 0, y: Int(imageView.frame.maxY+10), width: 300, height: 50)
        textView = UITextView(frame: rect)
        self.view.addSubview(textView)
        
    }
    
    
    func updateUI(index:Int) -> Void {
        let item = items[index]
        if item.url.startAccessingSecurityScopedResource(){
            imageView.image = UIImage(contentsOfFile: item.url.path)
            item.url.stopAccessingSecurityScopedResource()
        }
        
        label?.text = item.title
        textView.text = item.text
    }
    
    func didReceive(_ response: UNNotificationResponse, completionHandler completion: @escaping (UNNotificationContentExtensionResponseOption) -> Void) {
        if response.actionIdentifier == "switchOpen"{
            if index == 0{
             index = 1
            }else{
             index = 0
            }
            updateUI(index: index)
            completion(.doNotDismiss)
        }else if(response.actionIdentifier == "open"){
          completion(.dismissAndForwardAction)
        }else if(response.actionIdentifier == "dismiss"){
         completion(.dismiss)
        }else{
         completion(.dismissAndForwardAction)
        }
    }
    
    func didReceive(_ notification: UNNotification) {
        self.label?.text = notification.request.content.body
        
        let content = notification.request.content
        if let items = content.userInfo["items"] as? [[String:AnyObject]]{
            for i in 0..<items.count{
             let item = items[i]
                guard let title = item["title"] as?String,let text = item["text"] as? String else {
                    continue
                }
                
                if i > content.attachments.count - 1{
                 continue
                }
                
                let url = content.attachments[i].url
                
                let presentItem = NotificitonItem(url: url, title: title, text: text)
                self.items.append(presentItem)
            }
        }
        
        updateUI(index: 0)
    }

}
