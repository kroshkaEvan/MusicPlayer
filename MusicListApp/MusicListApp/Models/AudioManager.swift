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
//    var audioPlayer: AVAudioPlayer? {}
//    var duration: TimeInterval? {get set}
    func prepareToPlay(filePath: String)
    func playAudio()
    func getTime(_ type: Time) -> TimeInterval
    func setPlayer() -> Music

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
    
    func setPlayer() -> Music {
//        guard let isPlaying = audioPlayer?.isPlaying,
//              let duration = audioPlayer?.duration else { return Music(isPlaying: false,
//                                                                       maxValue: 0.0)}
        guard let audioPlayer = audioPlayer else {return Music(isPlaying: false,
                                                               maxValue: 0,
                                                               currentTime: 0,
                                                               remaningTime: 0)}
        
//        return Music(isPlaying: isPlaying,
//                     maxValue: Float(duration))
        print("\(audioPlayer.duration - audioPlayer.currentTime)")
        return Music(isPlaying: audioPlayer.isPlaying,
                     maxValue: Float(audioPlayer.duration),
                     currentTime: audioPlayer.currentTime,
                     remaningTime: audioPlayer.duration - audioPlayer.currentTime)

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
//        if type == .current {
//            return audioPlayer.currentTime
//        } else {
//            return audioPlayer.duration - audioPlayer.currentTime
//        }
    }
}
