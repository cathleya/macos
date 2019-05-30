//
//  ViewController.swift
//  Binding
//
//  Created by herry on 27/07/2017.
//  Copyright © 2017 herry. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    var currentUser:User?
    
    dynamic var users:[User] = []
    
    
    @IBOutlet weak var tableview: NSTableView!
    
    @IBOutlet weak var firstField: NSTextField!
    
    @IBOutlet weak var lastField: NSTextField!
    

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

extension ViewController:NSTableViewDelegate{
    func tableViewSelectionDidChange(_ notification: Notification) {
        let user = users[tableview.selectedRow]
        currentUser = user
        firstField.stringValue = user.firstName
        lastField.stringValue = user.lastName
        
    }
}


extension ViewController:NSTextFieldDelegate{
    override func controlTextDidChange(_ obj: Notification) {
        currentUser?.firstName = firstField.stringValue
        currentUser?.lastName = lastField.stringValue
    }
}


