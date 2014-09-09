//
//  User.swift
//  245ruff
//
//  Created by nishiko on 2014/09/09.
//  Copyright (c) 2014年 nishiko. All rights reserved.
//

import Foundation

class User: NSCoder {
    var username: String;
    
    init(username: String) {
        self.username = username
    }
    
    init(coder aDecoder: NSCoder!) {
        self.username = aDecoder.decodeObjectForKey("username") as String
    }
    
    func encodeWithCoder(aCoder: NSCoder!) {
        aCoder.encodeObject(self.username, forKey: "username")
    }
}