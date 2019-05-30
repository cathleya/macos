//
//  SongsListController.swift
//  SwiftPlayer
//
//  Created by herry on 05/08/2017.
//  Copyright © 2017 herry. All rights reserved.
//

import Cocoa
import AVFoundation

class SongsListController: NSViewController {
    
    dynamic var songs:[Song]=[]
    
    @IBOutlet weak var tableview: NSTableView!


    @IBAction func doubleClickAction(_ sender: NSTableView) {
        let index = sender.selectedRow
        if index >= 0 && index < songs.count  {
            let  song = songs[index]
            PlayerManager.shared.playSong(song: song)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do view setup here.
        
        songs = SongsManager().importSongs()!
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.playingSongsChanged(_:)), name: NSNotification.Name(rawValue: PlayerNotificaton.changSongs), object: nil)
        
    }
    
    
    
    func playingSongsChanged(_ notificaton:Notification) {
        
        let songName = notificaton.userInfo!["title"] as! String
        let array = songs.filter{item->Bool in
            return item.title == songName
        }
        
        let index = songs.index(of: array[0])
        let set = IndexSet(integer: index!)
        tableview.selectRowIndexes(set, byExtendingSelection: false)
    
    }
    
}
