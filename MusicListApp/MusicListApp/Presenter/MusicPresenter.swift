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
    
    func getSongs() -> [Song]
    func getSongImage(index: Int) -> UIImage?
    func prepareToPlay(index: Int)
    func playMusic()
}

class MusicPresenter: MainPresenterProtocol {
    
    // MARK: - Properties
    
    weak var view: MusicViewProtocol?
    weak var audioManager: AudioManagerProtocol?
    
    // MARK: - Initializer
    
    required init(view: MusicViewProtocol,
                  audioManager: AudioManagerProtocol) {
        self.view = view
        self.audioManager = audioManager
    }
    
    // MARK: - Methods
    
    func getSongs() -> [Song] {
        return DataSongs.data
    }
    
    func getSongImage(index: Int) -> UIImage? {
        return DataSongs.data[index].imageName
    }
    
    func prepareToPlay(index: Int) {
        audioManager?.prepareToPlay(index: index)
    }
    
    func playMusic() {
        audioManager?.playAudio()
    }

}





