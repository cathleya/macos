//
//  CVItem.swift
//  Collection
//
//  Created by herry on 29/07/2017.
//  Copyright © 2017 herry. All rights reserved.
//

import Cocoa

class CVItem: NSCollectionViewItem {
    
    let label = NSTextField(frame: NSMakeRect(0, 0, 60, 30))
    
    var happy:String?{
        set{
            label.stringValue = "\(newValue!)"
        }
        get{
            return self.happy
        }
    }

    
    override func loadView() {
        
        label.backgroundColor = NSColor.green

        view = label

    }
    
}
