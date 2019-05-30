//
//  AppDelegate.swift
//  SwiftPlayer
//
//  Created by herry on 04/08/2017.
//  Copyright © 2017 herry. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
    let popoer = NSPopover()
    var eventMonitor:EventMonitor?
    
    let Preference = NSWindowController(window: NSWindow())

    @IBAction func preferenceAction(_ sender: NSMenuItem) {
        
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        Preference.contentViewController = storyboard.instantiateController(withIdentifier: "PreferenceController") as! PreferenceController
        Preference.showWindow(self)
        
        Preference.window?.title = "Preference"
        
        Preference.window?.styleMask = [.titled,.closable,.miniaturizable,.resizable]
        
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        if let button = statusItem.button {
            button.image = NSImage(named: "star")
            button.action = #selector(toggleWeather(_:))
        }
        
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        popoer.contentViewController = storyboard.instantiateController(withIdentifier: "StatusController") as! StatusController
        
        eventMonitor = EventMonitor(mask: [.leftMouseUp,.rightMouseUp], handler: {(event)->() in
            if self.popoer.isShown{
                self.closePopover(event!)
            }
        })
        
        
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    //MARK: -- popover view show
    func toggleWeather(_ sender:NSStatusBarButton)  {
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

