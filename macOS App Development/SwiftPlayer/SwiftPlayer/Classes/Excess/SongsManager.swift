//
//  SongsManager.swift
//  SwiftPlayer
//
//  Created by herry on 05/08/2017.
//  Copyright © 2017 herry. All rights reserved.
//

import Cocoa
import iTunesLibrary

class SongsManager: NSObject {
    
    let formater = DateComponentsFormatter()
    
    private(set) var songs:[Song] = []
    
    static let shared:SongsManager = {
        return SongsManager()
    }()
    
    func importSongs() -> [Song]? {
        
        do{
            let library = try ITLibrary(apiVersion: "1.0")
            let allItems = library.allMediaItems
            let songs = allItems.filter({item->Bool in
                return item.mediaKind == ITLibMediaItemMediaKind.kindSong
                        && item.location != nil
                        && item.locationType == ITLibMediaItemLocationType.file
            }).map{item->Song in
                
                let time = Double(item.totalTime) / 1000.0
                
                return Song(title: item.title, location: (item.location?.path)!, length: self.formater.string(from: time)!,artist:(item.artist?.name)!,album:item.album.title!,image:(item.artwork?.image)!)
            }
            
            SongsManager.shared.songs = songs
            
            return songs
        
        }catch let error{
            print("There is unknow error in reading songs from itunes\(error)")
        }
        
        return []
    }
}
