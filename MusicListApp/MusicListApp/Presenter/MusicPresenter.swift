//
//  MusicPresenter.swift
//  MusicListApp
//
//  Created by Эван Крошкин on 4.09.22.
//

import Foundation
import UIKit

protocol MainPresenterProtocol: AnyObject {
    init(view: MusicViewProtocol,
         audioManager: AudioManagerProtocol)
    var music: Music? {get set}
    func setImage(index: Int) -> UIImage?
    func prepareToPlay(index: Int)
    func playMusic()
}

class MusicPresenter: MainPresenterProtocol {
    
    // MARK: - Properties
    
    weak var view: MusicViewProtocol?
    weak var audioManager: AudioManagerProtocol?
    
    var music: Music?
    private var timer: Timer?
    
    // MARK: - Initializer
    
    required init(view: MusicViewProtocol,
                  audioManager: AudioManagerProtocol) {
        self.view = view
        self.audioManager = audioManager
        setMusicPlayer()
    }
    
    // MARK: - Methods
    
    func setMusicPlayer() {
        self.music = audioManager?.setPlayer()
    }
    
    func setImage(index: Int) -> UIImage? {
        return music?.data[index].image
    }
    
    func prepareToPlay(index: Int) {
        guard let filePath = music?.data[index].filePath else {return}
        audioManager?.prepareToPlay(filePath: filePath)
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 1,
                                         target: self,
                                         selector: #selector(updateTime),
                                         userInfo: nil,
                                         repeats: true)
        }
    }
    
    func playMusic() {
        audioManager?.playAudio()
        guard let isPlaying = music?.isPlaying else { return }
        if isPlaying {
            timer?.invalidate()
            timer = nil
        }
    }
    
    private func getFormattedTime(_ timeInterval: TimeInterval) -> String {
        let minutes = timeInterval / 60
        let seconds = timeInterval.truncatingRemainder(dividingBy: 60)
        let timeFormatter = NumberFormatter()
        timeFormatter.minimumIntegerDigits = 2
        timeFormatter.minimumFractionDigits = 0
        timeFormatter.roundingMode = .down
        guard let minuteString = timeFormatter.string(from: NSNumber(value: minutes)),
              let secondString = timeFormatter.string(from: NSNumber(value: seconds)) else { return "00:00"}
        return "\(minuteString):\(secondString)"
    }
    
    @objc open func updateTime() {
        guard let currentTime = audioManager?.getTime(.current),
              let remaningTime = audioManager?.getTime(.remaning) else {return}
        view?.musicView?.musicSlider.value = Float(currentTime)
        view?.musicView?.currentTimeLabel.text = getFormattedTime(currentTime)
        view?.musicView?.remaningTimeLabel.text = getFormattedTime(remaningTime)
    }
}





