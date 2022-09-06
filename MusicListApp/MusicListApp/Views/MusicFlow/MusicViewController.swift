//
//  ViewController.swift
//  MusicListApp
//
//  Created by Эван Крошкин on 2.09.22.
//

import UIKit
import SnapKit

class MusicViewController: UIViewController {
    
    private var musicView: MusicView? {
        guard isViewLoaded else { return nil }
        return view as? MusicView
    }
    
    var presenter: MainPresenterProtocol?
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        addAllAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadDataCell(index: currentIndex)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    private func setupLayout() {
        view = MusicView()
        musicView?.collectionView.dataSource = self
        musicView?.collectionView.delegate = self
    }
    
    private func addAllAction() {
        musicView?.playMusicButton.addTarget(self,
                                             action: #selector(didTapPlayMusic),
                                             for: .touchUpInside)
        musicView?.backwardMusicButton.addTarget(self,
                                                 action: #selector(didTapPreviousMusic),
                                                 for: .touchUpInside)
        musicView?.nextMusicButton.addTarget(self,
                                             action: #selector(didTapNextMusic),
                                             for: .touchUpInside)
    }
    
    private func flipAudio(next: Bool) {
        guard let data = presenter?.getSongs() else { return }
        var index = 0
        if next {
            index = currentIndex == data.count - 1 ? 0 : currentIndex + 1
        } else {
            index = currentIndex == 0 ? data.count - 1 : currentIndex - 1
        }
        
        musicView?.collectionView.scrollToItem(at: IndexPath(row: index, section: 0),
                                               at: .centeredHorizontally,
                                               animated: false)
        currentIndex = index
        reloadDataCell(index: currentIndex)
        presenter?.playMusic()
    }
    
    @objc private func didTapPlayMusic() {
        presenter?.playMusic()
    }
    
    @objc private func didTapPreviousMusic() {
        flipAudio(next: false)
    }
    
    @objc private func didTapNextMusic() {
        flipAudio(next: true)
    }
}

extension MusicViewController: MusicViewProtocol {
    func changeCellPosition(velocity: CGPoint,
                            targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        guard let data = presenter?.getSongs() else { return }
        if let cellItemWidth = musicView?.cellItemWidth,
           let cellContentInset = musicView?.cellContentInset,
           let cellSpacing = musicView?.cellSpacing {
            let currentCellWidth = cellItemWidth + cellContentInset - cellSpacing
            var newIndex = currentIndex
            var newCellWidth: CGFloat = 0
            musicView?.collectionView.reloadItems(at: [IndexPath(row: currentIndex,
                                                                 section: 0)])
            if currentIndex != 0 {
                newCellWidth = cellItemWidth + cellContentInset
            }
            if velocity.x != 0 {
                newIndex = velocity.x > 0 ? currentIndex + 1 : currentIndex - 1
                if newIndex < 0 {
                    newIndex = data.count - 1
                }
                if newIndex > data.count - 1 {
                    newIndex = 0
                }
            }
            currentIndex = newIndex
            let xPoint = CGFloat(newIndex - 1) * newCellWidth + currentCellWidth
            targetContentOffset.pointee = CGPoint(x: xPoint,
                                                  y: 0)
        }
    }
    
    func reloadDataCell(index: Int) {
        guard presenter?.getSongs().count != nil,
              let data = presenter?.getSongs()[index] else {
                  musicView?.songNameLabel.text = ""
                  musicView?.musicanNameLabel.text = ""
                  return
              }
        presenter?.prepareToPlay(index: index)
        musicView?.songNameLabel.text = data.name
        musicView?.musicanNameLabel.text = data.singer
    }
}

extension MusicViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.getSongs().count ?? 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MusicCollectionViewCell.identifier,
                                                      for: indexPath)
        if let cell = cell as? MusicCollectionViewCell {
            cell.songImageView.image = presenter?.getSongImage(index: indexPath.row)
        }
        return cell
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                   withVelocity velocity: CGPoint,
                                   targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        changeCellPosition(velocity: velocity,
                           targetContentOffset: targetContentOffset)
        reloadDataCell(index: currentIndex)
        presenter?.playMusic()
    }
}

