//
//  StatusController.swift
//  SwiftPlayer
//
//  Created by herry on 06/08/2017.
//  Copyright © 2017 herry. All rights reserved.
//

import Cocoa

class StatusController: NSViewController {
    
    
    @IBOutlet weak var playingbtn: NSButton!
    
    @IBOutlet weak var songName: NSTextField!
    
    @IBOutlet weak var songTime: NSTextField!
    
    @IBOutlet weak var songImage: NSImageView!
    
    @IBOutlet weak var repeatBtn: NSButton!
    
    @IBOutlet weak var shuffleBtn: NSButton!
    
    
    
    @IBAction func playing(_ sender: NSButton) {
        
        if !PlayerManager.shared.toggleplay() {
            sender.image = NSImage(named: "stopping")
        }
    }


    @IBAction func playPrevious(_ sender: Any) {
        let currentSong = PlayerManager.shared.currentSong
        let songArray = SongsManager.shared.songs
        
        if currentSong == nil {
            if songArray.count > 0 {
                PlayerManager.shared.playSong(song: songArray[0])
            }
        }else{
            if songArray.count > 1 {
                if UserDefaults.standard.bool(forKey: "playingcycle") {
                    //repeat again possibly
                    let nextIndex = randomCustom(min: 0, max: songArray.count-1)
                    let nextSong = songArray[nextIndex]
                    PlayerManager.shared.playSong(song: nextSong)
                }else{
                    let index = songArray.index(of: currentSong!)
                    var nextIndex = 0
                    if index! < 1 {
                        nextIndex = songArray.count-1
                    }else{
                        nextIndex = songArray.index(before: index!)
                    }
                    
                    let nextSong = songArray[nextIndex]
                    PlayerManager.shared.playSong(song: nextSong)
                }
            }else{
                PlayerManager.shared.playSong(song: currentSong!)
            }
        }

    }
    
    
    @IBAction func playNext(_ sender: NSButton?) {
        let currentSong = PlayerManager.shared.currentSong
        let songArray = SongsManager.shared.songs
        
        if currentSong == nil {
            if songArray.count > 0 {
                PlayerManager.shared.playSong(song: songArray[0])
            }
        }else{
            if songArray.count > 1 {
                if UserDefaults.standard.bool(forKey: "playingcycle") {
                    //repeat again possibly
                    let nextIndex = randomCustom(min: 0, max: songArray.count-1)
                    let nextSong = songArray[nextIndex]
                    PlayerManager.shared.playSong(song: nextSong)
                }else{
                    let index = songArray.index(of: currentSong!)
                    var nextIndex = 0
                    if index! > songArray.count-2 {
                        nextIndex = 0
                    }else{
                        nextIndex = songArray.index(after: index!)
                    }
                    
                    let nextSong = songArray[nextIndex]
                    PlayerManager.shared.playSong(song: nextSong)
                }
            }else{
                PlayerManager.shared.playSong(song: currentSong!)
            }
        }

    }
    
    
    @IBAction func repeatModel(_ sender: NSButton) {
        sender.image = NSImage(named: "repeat")
        shuffleBtn.image = NSImage(named: "shufflesel")
        UserDefaults.standard.set(false, forKey: "playingcycle")
    }
    

    @IBAction func shuffleModel(_ sender: NSButton) {
        sender.image = NSImage(named: "shuffle")
        repeatBtn.image = NSImage(named: "repeatsel")
        UserDefaults.standard.set(true, forKey: "playingcycle")

    }
    
    @IBAction func volumeChaged(_ sender: NSSlider) {
        print(sender.floatValue)
        PlayerManager.shared.changeValume(valume:sender.floatValue)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        NotificationCenter.default.addObserver(self, selector: #selector(self.playingtimeChanged(_:)), name: NSNotification.Name(rawValue: PlayerNotificaton.currentTime), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.playingSongsChanged(_:)), name: NSNotification.Name(rawValue: PlayerNotificaton.changSongs), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.playingSongFinished(_:)), name: NSNotification.Name(rawValue: PlayerNotificaton.completePlaying), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.pauseStatusChanged(_:)), name: NSNotification.Name(rawValue: PlayerNotificaton.pauseSong), object: nil)
        
        let song = PlayerManager.shared.currentSong
        if song != nil {
            self.songName.stringValue = (song?.title)!
            self.songImage.image = song?.image
            playingbtn.image = NSImage(named: "playing")
        }

        
    }
    
    func playingtimeChanged(_ notificaton:Notification) {
        guard let sender = notificaton.userInfo?["current"] as? String else {return}
        self.songTime.stringValue = sender
    }
    
    func playingSongsChanged(_ notificaton:Notification) {
        
        self.songName.stringValue = notificaton.userInfo!["title"] as! String
        self.songImage.image = notificaton.userInfo!["image"] as? NSImage
        
        playingbtn.image = NSImage(named: "playing")
    }
    
    func playingSongFinished(_ notificaton:Notification)  {
        self.playNext(nil)
    }
    
    func pauseStatusChanged(_ notificaton:Notification)  {
        
        let sender = notificaton.userInfo!["pause"] as! Bool
        if sender {
            playingbtn.image = NSImage(named: "playing")
        }else{
            playingbtn.image = NSImage(named: "stopping")
        }
        
    }

    
    func randomCustom(min: Int, max: Int) -> Int {
        let y = arc4random() % UInt32(max) + UInt32(min)
        print(Int(y))
        return Int(y)
    }
    
    
}
