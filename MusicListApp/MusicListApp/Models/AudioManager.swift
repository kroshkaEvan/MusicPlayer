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
    func prepareToPlay(filePath: String)
    func playAudio()
    func getTime(_ type: Time) -> TimeInterval
}

class AudioManager: NSObject, AudioManagerProtocol, AVAudioPlayerDelegate {
    static let shared = AudioManager()
    
    private var audioPlayer: AVAudioPlayer?
    
    func prepareToPlay(filePath: String) {
        guard let audioURL = Bundle.main.url(forResource: filePath,
                                             withExtension: "mp3") else {return}
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: audioURL)
            audioPlayer?.delegate = self
            audioPlayer?.prepareToPlay()
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func playAudio() {
        guard let isPlaying = audioPlayer?.isPlaying else { return }
        if isPlaying {
            audioPlayer?.pause()
        } else {
            audioPlayer?.play()
        }
    }

    func getTime(_ type: Time) -> TimeInterval {
        guard let audioPlayer = audioPlayer else {return 0}
        switch type {
        case .current:
            return audioPlayer.currentTime
        case .remaning:
            return audioPlayer.duration - audioPlayer.currentTime
        }
    }
}
