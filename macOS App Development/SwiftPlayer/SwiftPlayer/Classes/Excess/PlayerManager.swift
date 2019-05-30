//
//  PlayerManager.swift
//  SwiftPlayer
//
//  Created by herry on 05/08/2017.
//  Copyright © 2017 herry. All rights reserved.
//

import Cocoa
import AVFoundation

struct PlayerNotificaton {
    static let currentTime = "currentTime"
    static let completePlaying = "completePlaying"
    static let changSongs = "changSongs"
    static let pauseSong = "pauseSong"
}

class PlayerManager: NSObject ,AVAudioPlayerDelegate{
    
//    var doveClosure:((_ currentTime:String)->())!
//    var completeClosure:((_ finished:Bool)->())!
//    var changeSongClosure:((_ sender:[String:Any])->())!
    
    var songPlayer:AVAudioPlayer?
    private(set) var currentSong:Song?
    var timer:Timer?

    let formatter:DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour,.minute,.second]
        formatter.zeroFormattingBehavior = .pad
        return formatter
    }()
    
    
    static let shared:PlayerManager = {

        return PlayerManager()
    }()
    
    // MARK: -- AVAudioPlayerDelegate
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool){
        timer?.invalidate()
        timer = nil
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: PlayerNotificaton.completePlaying), object: nil)
        print("play songs successfully \(flag)")
    }
    
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?){
        timer?.invalidate()
        timer = nil
        print("play songs unsuccessfully \(error!)")
    }
    
    func playSong(song:Song) {
        
        self.currentSong = song
        let path = URL(fileURLWithPath: song.location)
        
        songPlayer = try! AVAudioPlayer(contentsOf: path)
        songPlayer?.delegate = self
        songPlayer?.volume = 0.1
        songPlayer?.play()
        
        let dict = ["title":song.title,"image":song.image!] as [String : Any]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: PlayerNotificaton.changSongs), object: nil, userInfo: dict)
        
        timer?.invalidate()
        timer = nil
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: {(sender) in
            self.postCurrentTime()
        })
        
        
    }
    
    func toggleplay()->Bool {
        if songPlayer != nil {
            if (songPlayer?.isPlaying)! {
                songPlayer?.pause()
                timer?.invalidate()
                timer = nil
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: PlayerNotificaton.pauseSong), object: nil, userInfo: ["pause":false])
                return false
            }else{
                songPlayer?.play()
                timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: {(sender) in
                    self.postCurrentTime()
                })
                self.postCurrentTime()
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: PlayerNotificaton.pauseSong), object: nil, userInfo: ["pause":true])
                return true
            }
        }else{
            return false
        }
    }
    
    func postCurrentTime(){
        let currenet  = self.formatter.string(from: self.songPlayer!.currentTime)
        let dict = ["current":currenet!]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: PlayerNotificaton.currentTime), object: nil, userInfo: dict)

    }
    
    func changeValume(valume:Float) {
        songPlayer?.volume = valume
    }
    

}
