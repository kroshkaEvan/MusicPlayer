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
