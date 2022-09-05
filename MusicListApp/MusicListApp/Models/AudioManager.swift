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
        let audioURL = URL(fileURLWithPath: Bundle.main.path(forResource: DataSongs.data[index].filePath,
                                                              ofType: "mp3") ?? "")
        try? AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category(rawValue: AVAudioSession.Category.playback.rawValue))
        try? AVAudioSession.sharedInstance().setActive(true)
        UIApplication.shared.beginReceivingRemoteControlEvents()
        audioPlayer = try? AVAudioPlayer(contentsOf: audioURL)
        audioPlayer?.delegate = self
        audioPlayer?.prepareToPlay()
    }
    
    func playAudio() {
        guard let isPlaying = audioPlayer?.isPlaying else { return }
        if isPlaying {
            audioPlayer?.stop()
        } else {
            audioPlayer?.play()
        }
    }
}
