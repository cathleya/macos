//
//  Playlist.swift
//  OutlineView-9-12
//
//  Created by herry on 22/07/2017.
//  Copyright © 2017 herry. All rights reserved.
//

import Cocoa

class Playlist: NSObject {
    dynamic var name:String = "New Playlist"
    dynamic var creator:String = "User"
    
    func isLeaf() -> Bool {
        return true
    }

}
