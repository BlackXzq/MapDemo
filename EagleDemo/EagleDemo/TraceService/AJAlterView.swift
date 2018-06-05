//
//  AJAlterView.swift
//  Dealers
//
//  Created by Black on 2017/9/8.
//  Copyright © 2017年 Anji-Allways. All rights reserved.
//

import UIKit

class AJAlterView: NSObject {
    ///3.确认弹出框
    
    class func showTwoAction(title:String?,
                             message:String?,
                             target: UIViewController?,
                             confirmTitle: String = "确定",
                             cacelTitle: String = "取消",
                             confirmHandler: ( (UIAlertAction) -> Swift.Void)? = nil,
                             cancelHandler: ( (UIAlertAction) -> Swift.Void)? = nil)
    {
        
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: cacelTitle, style: .cancel, handler: cancelHandler)
        alertVC.addAction(cancelAction)
    
        let entureAction = UIAlertAction(title: confirmTitle, style: .destructive, handler: confirmHandler)
        alertVC.addAction(entureAction)
        
        target?.present(alertVC, animated: true, completion: nil)
        
    }
    
    class func showSigleAction(title:String?,
                               message:String?,
                               target: UIViewController?,
                               confirmTitle: String = "确定",
                               confirmHandler: ( (UIAlertAction) -> Swift.Void)? = nil)
    {
        
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let entureAction = UIAlertAction(title: confirmTitle, style: .destructive, handler: confirmHandler)
        alertVC.addAction(entureAction)
        
        target?.present(alertVC, animated: true, completion: nil)
        
    }
    
}

