//
//  ViewController.swift
//  Tests-13-15
//
//  Created by herry on 22/07/2017.
//  Copyright © 2017 herry. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var label: NSTextField!
    @IBAction func tapAction(_ sender: NSButton) {
        
        let alert = NSAlert()
        alert.messageText = "Alert message"
        alert.informativeText = "Detailed description of alert"
        alert.addButton(withTitle: "default")
        alert.addButton(withTitle: "alternative")
        alert.addButton(withTitle: "other")
        alert.beginSheetModal(for: view.window!, completionHandler: {(response)->() in
            print("user selected \(response)")
            
            switch response{
            case NSAlertFirstButtonReturn:
                self.label.stringValue = "first"
            case NSAlertSecondButtonReturn:
                self.label.stringValue = "second"
            case NSAlertThirdButtonReturn:
                self.label.stringValue = "third"
            default:break
            }
            
        })
        
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

