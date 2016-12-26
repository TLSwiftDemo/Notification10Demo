//
//  TimeDelay.swift
//  Notification10Demo
//
//  Created by Andrew on 2016/10/11.
//  Copyright © 2016年 Andrew. All rights reserved.
//

import Foundation

func delay(time timeIntval:TimeInterval,_ block:  @escaping ()->Void) -> Void
{
    let after = DispatchTime.now() + timeIntval
    DispatchQueue.main.asyncAfter(deadline:after,execute:block)
}


