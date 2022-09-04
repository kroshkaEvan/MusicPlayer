//
//  AudioManager.swift
//  MusicListApp
//
//  Created by Эван Крошкин on 4.09.22.
//

import Foundation
import UIKit
import AVFoundation
import MediaPlayer

protocol AudioManagerProtocol: AnyObject {
    func prepareToPlay(index: Int)
    func playAudio()
}

class AudioManager: NSObject, AudioManagerProtocol, AVAudioPlayerDelegate {
    static let shared = AudioManager()
    
    private var audioPlayer: AVAudioPlayer?
    
    func prepareToPlay(index: Int) {
        let audioPath = URL(fileURLWithPath: Bundle.main.path(forResource: DataSongs.data[index].filePath,
                                                              ofType: "mp3") ?? "")
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category(rawValue: AVAudioSession.Category.playback.rawValue))
        } catch {
            
        }
        do {
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            
        }
        UIApplication.shared.beginReceivingRemoteControlEvents()
        
        audioPlayer = try? AVAudioPlayer(contentsOf: audioPath)
        audioPlayer?.delegate = self
        audioPlayer?.prepareToPlay()
    }
    
    func playAudio() {
        guard let isPlaying = audioPlayer?.isPlaying else {
            return
        }
        if isPlaying {
            audioPlayer?.stop()
        } else {
            audioPlayer?.play()
        }
    }
}
