//
//  ModuleBuilder.swift
//  MusicListApp
//
//  Created by Эван Крошкин on 5.09.22.
//

import Foundation
import UIKit

protocol Builderble {
    static func createMusicModule() -> UIViewController
}

class ModuleBuilder: Builderble {
    static func createMusicModule() -> UIViewController {
        let view = MusicViewController()
        let audioManager = AudioManager.shared
        let presenter = MusicPresenter(view: view,
                                       audioManager: audioManager)
        view.presenter = presenter
        return view
    }
}
