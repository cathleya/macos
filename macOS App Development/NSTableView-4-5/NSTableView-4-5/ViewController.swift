//
//  ViewController.swift
//  NSTableView-4-5
//
//  Created by herry on 15/07/2017.
//  Copyright © 2017 herry. All rights reserved.
//

import Cocoa

class ViewController: NSViewController,NSTableViewDataSource,NSTextFieldDelegate {
    
    
    
    @IBOutlet weak var tableview: NSTableView!
    
    
    @IBOutlet weak var textfield: NSTextField!
    
    
    
    @IBAction func addfruit(_ sender: NSButton?) {
        
        print(strings.count)
        let fruit = textfield.stringValue
        strings.append(fruit)
        textfield.stringValue = ""
        tableview.reloadData()
        
        print(strings.count)

        
    }
    
    
    var strings = ["apple","orange","waterlemon"]
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    
        
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return strings.count
    }
    
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        return strings[row]
    }
    
//    override func controlTextDidEndEditing(_ obj: Notification) {
//        addfruit(nil)
//    }
    
    
    

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

