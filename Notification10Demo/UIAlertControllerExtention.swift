//
//  UIAlertControllerExtention.swift
//  Notification10Demo
//
//  Created by Andrew on 2016/10/11.
//  Copyright © 2016年 Andrew. All rights reserved.
//

import UIKit

extension UIAlertController {

    static func showConfirmAlert(message:String,in viewController:UIViewController) -> Void {
        let alert = UIAlertController(title: nil
            , message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        viewController.present(alert, animated: true)
    }
    
    static func showAlert(message:String){
        if let vc = UIApplication.shared.keyWindow?.rootViewController{
         showConfirmAlert(message: message, in: vc)
        }
    }
}
