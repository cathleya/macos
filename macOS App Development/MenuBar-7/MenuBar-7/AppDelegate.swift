//
//  AppDelegate.swift
//  MenuBar-7
//
//  Created by herry on 20/07/2017.
//  Copyright © 2017 herry. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
    let menu = NSMenu()
    

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        
        if let button = statusItem.button {
            button.image = NSImage(named: "star")
            //button.action = #selector(showWeather(_:))
        }
        
        menu.addItem(NSMenuItem(title: "show weather", action: #selector(showWeather(_:)), keyEquivalent: "S"))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(terminate(_:)), keyEquivalent: "Q"))
        statusItem.menu = menu
        
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func showWeather(_ sender:NSStatusBarButton) {
        print("sunshine")
        
    }
    
    func terminate(_ sender:NSStatusBarButton) {
        exit(0)
    }

}

