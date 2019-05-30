//
//  ViewController.swift
//  OutlineView-9
//
//  Created by herry on 21/07/2017.
//  Copyright © 2017 herry. All rights reserved.
//

import Cocoa

class ViewController: NSViewController,NSOutlineViewDataSource ,NSOutlineViewDelegate{

    
    @IBOutlet weak var outlineview: NSOutlineView!
    
    @IBOutlet var treecontroller: NSTreeController!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addData()
        
        outlineview.expandItem(nil, expandChildren: true)

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear() {
        let alert = NSAlert()
        alert.messageText = "alert message"
        alert.informativeText = "detailed description of alert message"
        alert.addButton(withTitle: "default")
        alert.addButton(withTitle: "alternative")
        alert.addButton(withTitle: "other")
        alert.beginSheetModal(for: view.window!, completionHandler: {(response)->()in
            print("The user selected \(response)")
        })
    }

    
    func addData(){
        
        let root = [
            "name":"Library",
            "isLeaf":false,
            "children":[Playlist(),Playlist()]
        ] as [String : Any]
        

        print(root)
        
        treecontroller.addObject(root)
        
        
    }
    
    
    func isHeader(item:Any) -> Bool {
        if let item = item as? NSTreeNode {
            return !(item.representedObject is Playlist)
        }else{
            return !(item is Playlist)
        }
    }
    
    
    func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView? {
        if isHeader(item: item) {
            return outlineView.make(withIdentifier: "HeaderCell", owner: self)
        }else{
            return outlineView.make(withIdentifier: "DataCell", owner: self)
        }
    }
    
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

