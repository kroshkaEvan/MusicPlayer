//
//  MusicViewProtocol.swift
//  MusicListApp
//
//  Created by Эван Крошкин on 4.09.22.
//

import Foundation
import UIKit

protocol MusicViewProtocol: AnyObject {
    var musicView: MusicView? {get}
    func changeCellPosition(velocity: CGPoint,
                            targetContentOffset: UnsafeMutablePointer<CGPoint>)
    func reloadDataCell(index: Int)
}
