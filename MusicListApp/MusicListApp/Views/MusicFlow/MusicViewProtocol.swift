//
//  MusicViewProtocol.swift
//  MusicListApp
//
//  Created by Эван Крошкин on 4.09.22.
//

import Foundation
import UIKit

protocol MusicViewProtocol: AnyObject {
    func changeCellPosition(velocity: CGPoint,
                            targetContentOffset: UnsafeMutablePointer<CGPoint>)
    func reloadDataCell(index: Int)
}
