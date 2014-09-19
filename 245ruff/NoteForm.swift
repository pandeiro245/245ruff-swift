//
//  NoteForm.swift
//  245ruff
//
//  Created by nishiko on 2014/09/17.
//  Copyright (c) 2014年 nishiko. All rights reserved.
//

import UIKit

class NoteForm: NSObject, FXForm {
    var title: String!
    var isPrivate: Bool! = false
    
    func fields() -> [AnyObject]! {
        return ["title", "isPrivate"]
    }
    
    func titleField() -> AnyObject! {
        return ["type", "isPrivate"]
    }
    
    func isPrivateField() -> AnyObject! {
        return [
            "type" : "boolean",
            "action" : "isPrivateDidTap:"
        ]
    }
    
    func extraFields() -> [AnyObject]! {
        return [
            [
                "title" : NSLocalizedString("Submit", comment: ""),
                "header" : "",
                "action" : "submitDidTap"
            ]
        ]
    }
}
