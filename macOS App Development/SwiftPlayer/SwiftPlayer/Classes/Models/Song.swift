//
//  Song.swift
//  SwiftPlayer
//
//  Created by herry on 05/08/2017.
//  Copyright © 2017 herry. All rights reserved.
//

import Cocoa

class Song: NSObject {
    
    dynamic var title:String = ""
    dynamic var location:String = ""
    dynamic var length:String = ""
    dynamic var artist:String = ""
    dynamic var album:String = ""
    dynamic var image:NSImage? = nil
    
    convenience init(title:String,location:String,length:String,artist:String,album:String,image:NSImage) {
        self.init()
        
        self.title = title
        self.location = location
        self.length = length
        self.artist = artist
        self.album = album
        self.image = image
        
    }

}
