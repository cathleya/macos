//
//  AppDelegate.swift
//  Timer-74-76
//
//  Created by herry on 26/07/2017.
//  Copyright © 2017 herry. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let preference = NSStoryboard(name: "Main", bundle: nil).instantiateController(withIdentifier: "PreferenceWC") as! PreferenceWC
    

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    @IBAction func preferenceShow(_ sender: NSMenuItem) {
        preference.showWindow(self)
        
    }

}

