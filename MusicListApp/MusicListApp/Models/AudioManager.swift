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
    func downloadFile(_ filePath: String)
    func prepareToPlay(filePath: String)
    func playAudio()
    func getTime(_ type: Time) -> TimeInterval
}

final class AudioManager: NSObject, AudioManagerProtocol, AVAudioPlayerDelegate {
    static let shared = AudioManager()
    
    private var audioPlayer: AVAudioPlayer?
    
    // MARK: - Methods
    
    func downloadFile(_ filePath: String) {
        guard let audioURL = Bundle.main.url(forResource: filePath,
                                             withExtension: "mp3") else {return}
        let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory,
                                                                in: .userDomainMask).first!
        let destinationUrl = documentsDirectoryURL.appendingPathComponent(audioURL.lastPathComponent)
        if FileManager.default.fileExists(atPath: destinationUrl.path) {
            print("The file already exists at path")
        } else {
            URLSession.shared.downloadTask(with: audioURL,
                                           completionHandler: { (location, response, error) -> Void in
                guard let location = location,
                        error == nil else { return }
                do {
                    try FileManager.default.moveItem(at: location,
                                                     to: destinationUrl)
                    print("File moved to documents folder")
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }).resume()
        }
    }
    
    func prepareToPlay(filePath: String) {
        guard let audioURL = Bundle.main.url(forResource: filePath,
                                             withExtension: "mp3") else {return}
        let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory,
                                                                in: .userDomainMask).first!
        let destinationUrl = documentsDirectoryURL.appendingPathComponent(audioURL.lastPathComponent)
        
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: destinationUrl)
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
