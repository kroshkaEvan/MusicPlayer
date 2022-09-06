//
//  Song.swift
//  MusicListApp
//
//  Created by Эван Крошкин on 4.09.22.
//

import Foundation
import UIKit

struct Song {
    let name: String
    let singer: String
    let filePath: String
    let image: UIImage?
    
    init (name: String,
          singer: String,
          filePath: String,
          imageName: String) {
        self.name = name
        self.singer = singer
        self.filePath = filePath
        self.image = UIImage(named: imageName)
    }
}

//class DataSongs {
//    static let data: [Song] = [Song(name: "Beliver",
//                                    singer: "Imagine Dragons",
//                                    filePath: "imagine_dragon_-_beliver_(z2.fm)",
//                                    imageName: "ImagineDragons"),
//                               Song(name: "I Ain't Worried",
//                                    singer: "OneRepublic",
//                                    filePath: "OneRepublic - I Ain't Worried",
//                                    imageName: "topGun"),
//                               Song(name: "Moth To A Flame",
//                                    singer: "Swedish House Mafia, The Weeknd",
//                                    filePath: "muzika_v_mashinu_2022_-_swedish_house_mafia__the_weeknd_-_moth_to_a_flame_(z2.fm)",
//                                    imageName: "mothToAFlame")
//    ]
//}
