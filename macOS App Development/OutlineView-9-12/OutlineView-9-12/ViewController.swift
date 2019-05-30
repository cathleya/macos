//
//  ViewController.swift
//  OutlineView-9-12
//
//  Created by herry on 21/07/2017.
//  Copyright © 2017 herry. All rights reserved.
//

import Cocoa

class ViewController: NSViewController,NSOutlineViewDelegate ,NSOutlineViewDataSource{
    
    @IBOutlet weak var outlineview: NSOutlineView!
    @IBOutlet weak var treecontroller: NSTreeController!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        addData()
        outlineview.expandItem(nil, expandChildren: true)
        outlineview.deselectRow(0)
        outlineview.register(forDraggedTypes: [NSPasteboardTypeString])
        
        // Do any additional setup after loading the view.
    }
    
    
    func addData() {
        let root = [
                "name":"Library",
                "isLeaf":false
            ] as [String : Any]
        let dict = NSMutableDictionary(dictionary: root)
        let p1 = Playlist()
        p1.name = "P1"
        let p2 = Playlist()
        p2.name = "P2"
        dict.setObject([p1,p2], forKey: "children" as NSCopying)
        treecontroller.addObject(dict)
        
        treecontroller.addObject(dict)
        
    }
    
    func isheader(_ item:Any) -> Bool {
        if let item = item as? NSTreeNode {
           return !(item.representedObject is Playlist)
        }else{
            return !(item is Playlist)
        }
    }
    
    //MARK: - delegate
    func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView? {
        if isheader(item) {
            return outlineView.make(withIdentifier: "HeaderCell", owner: self)
        }else{
            return outlineView.make(withIdentifier: "DataCell", owner: self)
        }
    }
    
    //MARK: - datasource
    func outlineView(_ outlineView: NSOutlineView, pasteboardWriterForItem item: Any) -> NSPasteboardWriting? {
        let pbItem = NSPasteboardItem()
        if let playlist = (item as? NSTreeNode)?.representedObject as? Playlist {
            pbItem.setString(playlist.name , forType: NSPasteboardTypeString)
            return pbItem
        }
        return nil
    }
    
    func outlineView(_ outlineView: NSOutlineView, validateDrop info: NSDraggingInfo, proposedItem item: Any?, proposedChildIndex index: Int) -> NSDragOperation {
        
        if index>=0 && item != nil {
            return .move
        }else{
            return []
        }
    }
    
    func outlineView(_ outlineView: NSOutlineView, acceptDrop info: NSDraggingInfo, item: Any?, childIndex index: Int) -> Bool {
        
        let pb = info.draggingPasteboard()
        let name = pb.string(forType: NSPasteboardTypeString)
        
        var sourceNode:NSTreeNode?
        
        if let item = item as? NSTreeNode, item.children != nil {
            for node in item.children! {
                if let playlist = node.representedObject as? Playlist {
                    if playlist.name == name {
                        sourceNode = node
                    }
                }
            }
        }
        
        if sourceNode == nil {
            return false
        }
        
        let fromIndex = treecontroller.selectionIndexPath
        
        let indexArr = [0,index]
        let toIndexPath = NSIndexPath(indexes: indexArr, length: 2)
        treecontroller.move(sourceNode!, to: toIndexPath as IndexPath)
        
        (undoManager?.prepare(withInvocationTarget: self) as AnyObject).reverse(souceNode:sourceNode, fromIndex: fromIndex)
        undoManager?.setActionName("Move")
        
        return true
        
    }
    
    func reverse(souceNode:NSTreeNode?,fromIndex:IndexPath?) {
        treecontroller.move(souceNode!, to: fromIndex!)
    }
    
    
    
    
    // mark: - Group
    
    func outlineView(_ outlineView: NSOutlineView, isGroupItem item: Any) -> Bool {
        return isheader(item)
    }
    
    func outlineView(_ outlineView: NSOutlineView, shouldSelectItem item: Any) -> Bool {
        return !isheader(item)
    }
    

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

