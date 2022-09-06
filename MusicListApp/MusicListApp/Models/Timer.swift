//
//  Timer.swift
//  MusicListApp
//
//  Created by Эван Крошкин on 6.09.22.
//

import Foundation
import UIKit

class Music {
    let data: [Song] = [Song(name: "Beliver",
                             singer: "Imagine Dragons",
                             filePath: "imagine_dragon_-_beliver_(z2.fm)",
                             imageName: "ImagineDragons"),
                        Song(name: "I Ain't Worried",
                             singer: "OneRepublic",
                             filePath: "OneRepublic - I Ain't Worried",
                             imageName: "topGun"),
                        Song(name: "Moth To A Flame",
                             singer: "Swedish House Mafia, The Weeknd",
                             filePath: "muzika_v_mashinu_2022_-_swedish_house_mafia__the_weeknd_-_moth_to_a_flame_(z2.fm)",
                             imageName: "mothToAFlame")]
    
    var isPlaying: Bool?
}

enum Time {
    case remaning, current
}
