//
//  SettingsForm.swift
//  245ruff
//
//  Created by nishiko on 2014/09/19.
//  Copyright (c) 2014年 nishiko. All rights reserved.
//

import UIKit

class SettingsForm : NSObject, FXForm {
    
    func extraFields() -> [AnyObject]! {
        return [
            [
                "title" : AppConfiguration.sharedConfiguration.currentUser().username,
                "header" : "",
                "type" : "label",
            ],
            [
                "title" : NSLocalizedString("Sign out", comment: ""),
                "header" : "",
                "action" : "signOutDidTap",
            ]
        ]
    }
}
