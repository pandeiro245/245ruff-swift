//
//  Note.swift
//  245ruff
//
//  Created by nishiko on 2014/09/12.
//  Copyright (c) 2014年 nishiko. All rights reserved.
//

import Foundation

class Note: NSObject, NSCoding {
    var title: String
    var name: String
    var isPrivate: Bool
    var team: Team
    var label: String {
        return "\(team.name) - \(title)"
    }
    
    init(attributes: NSDictionary) {
        self.title = attributes["title"] as String
        self.name = attributes["name"] as String
        self.isPrivate = attributes["is_private"] as Bool
        self.team = Team(name: attributes["team"]!["name"] as String)
    }
    
    required init(coder aDecoder: NSCoder) {
        self.title = aDecoder.decodeObjectForKey("title") as String
        self.name = aDecoder.decodeObjectForKey("name") as String
        self.isPrivate = aDecoder.decodeBoolForKey("isPrivate") as Bool
        self.team = aDecoder.decodeObjectForKey("team") as Team
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.title, forKey: "title")
        aCoder.encodeObject(self.name, forKey: "name")
        aCoder.encodeBool(self.isPrivate, forKey: "isPrivate")
        aCoder.encodeObject(self.team, forKey: "team")
    }
}
