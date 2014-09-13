//
//  Team.swift
//  245ruff
//
//  Created by nishiko on 2014/09/12.
//  Copyright (c) 2014年 nishiko. All rights reserved.
//

import Foundation

class Team: NSObject, NSCoding {
    var name: String
    init(name: String) {
        self.name = name
    }
    
    required init(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObjectForKey("name") as String
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.name, forKey: "name")
    }
}