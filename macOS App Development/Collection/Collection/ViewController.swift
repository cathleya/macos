//
//  ViewController.swift
//  Collection
//
//  Created by herry on 29/07/2017.
//  Copyright © 2017 herry. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    var factor:[String] = ["happy","birthday","to","you"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let collectionView = NSCollectionView(frame:NSZeroRect)
        collectionView.dataSource = self
        
        
        let layout = NSCollectionViewFlowLayout()
        layout.itemSize = NSMakeSize(160, 30)
        layout.scrollDirection = .vertical
        collectionView.collectionViewLayout = layout;
        
        
        let scrollView = NSScrollView(frame: CGRect(x: 5, y: 150, width: 200, height: 100))
        scrollView.documentView = collectionView;
        view.addSubview(scrollView)
        
        collectionView.register(CVItem.self, forItemWithIdentifier: "CVItem")
        
        NSColor.cyan
        
        
    }
    

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}


extension ViewController : NSCollectionViewDataSource{
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return factor.count
    }
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let itemView = collectionView.makeItem(withIdentifier: "CVItem", for: indexPath) as! CVItem
        itemView.happy = factor[indexPath.item]
        return itemView
    }
}
