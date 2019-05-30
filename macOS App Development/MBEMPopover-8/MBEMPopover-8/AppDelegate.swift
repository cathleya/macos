//
//  AppDelegate.swift
//  MBEMPopover-8
//
//  Created by herry on 20/07/2017.
//  Copyright © 2017 herry. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
    let popoer = NSPopover()
    var eventMonitor:EventMonitor?
    

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        if let button = statusItem.button {
            button.image = NSImage(named: "star")
            button.action = #selector(toggleWeather(_:))
        }
        
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        popoer.contentViewController = storyboard.instantiateController(withIdentifier: "WeatherVC") as! WeatherVC
        
        eventMonitor = EventMonitor(mask: [.leftMouseUp,.rightMouseUp], handler: {(event)->() in
            if self.popoer.isShown{
                self.closePopover(event!)
            }
        })
        
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func toggleWeather(_ sender:NSStatusBarButton)  {
        print("sunshine")
        if popoer.isShown {
            closePopover(sender)
        }else{
            if let button = statusItem.button {
                popoer.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
                eventMonitor?.start()
            }
            
        }
    }
    
    func closePopover(_ sender:Any) {
        popoer.performClose(sender)
        eventMonitor?.stop()
    }


}

