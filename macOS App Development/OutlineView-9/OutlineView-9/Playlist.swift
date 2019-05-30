//
//  Playlist.swift
//  OutlineView-9
//
//  Created by herry on 21/07/2017.
//  Copyright © 2017 herry. All rights reserved.
//

import Cocoa

class Playlist: NSObject {
    
    dynamic var name:String = "New playlist"
    dynamic var creator:String = "User"
    func isLeaf() -> Bool {
        return true
    }

}
