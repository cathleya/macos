//
//  Song.swift
//  Tests-13-15
//
//  Created by herry on 23/07/2017.
//  Copyright © 2017 herry. All rights reserved.
//

import Cocoa

class Song: NSObject {
    
    var title:String
    var author:String
    var duration:Double
    
    init(title:String,author:String,duration:Double) {
        self.title = title
        self.author = author
        self.duration = duration
    }
    
    
}
