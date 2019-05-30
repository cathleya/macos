//
//  PreferenceVC.swift
//  Timer-74-76
//
//  Created by herry on 27/07/2017.
//  Copyright © 2017 herry. All rights reserved.
//

import Cocoa

class PreferenceVC: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    
    @IBAction func clickAction(_ sender: NSButton) {
        
        let popover = NSPopover()
        popover.behavior = .transient
        popover.contentViewController = NSStoryboard(name: "Main", bundle: nil).instantiateController(withIdentifier: "popover") as? NSViewController
        popover.show(relativeTo: sender.bounds, of: sender, preferredEdge: .maxX)
        
        
    }
    
    
    
    
}
