//
//  SignInForm.swift
//  245ruff
//
//  Created by nishiko on 2014/09/09.
//  Copyright (c) 2014年 nishiko. All rights reserved.
//

import UIKit

class SignInForm: NSObject, FXForm {
    var login: String!;
    var password: String!;
    
    func fields() -> [AnyObject]! {
        return ["login", "password"]
    }
    
    func loginField() -> AnyObject! {
        //return [FXFormFieldType : FXFormFieldTypeText]
        return ["type" : "text"]
    }
    
    func passwordField() -> AnyObject! {
        //return [FXFormFieldType : FXFormFieldTypePassword]
        return ["type" : "password"]
    }
    
    func extraFields() -> [AnyObject]! {
        return [
            [
                //FXFormFieldTitle : NSLocalizedString("Sign in", comment: ""),
                //FXFormFieldHeader : "",
                //FXFormFieldAction : "signInDidTap"
                "title" : NSLocalizedString("Sign in", comment: ""),
                "header" : "",
                "action" : "signInDidTap"
            ]
        ]
    }
}