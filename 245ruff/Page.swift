//
//  Page.swift
//  245ruff
//
//  Created by nishiko on 2014/09/17.
//  Copyright (c) 2014年 nishiko. All rights reserved.
//

import Foundation

class Page: NSObject {
    var title: String
    var content: String
    var note: Note
    
    init(title: String, content: String, note: Note) {
        self.title = title
        self.content = content
        self.note = note
    }
}