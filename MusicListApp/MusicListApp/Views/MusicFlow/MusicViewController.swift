//
//  ViewController.swift
//  MusicListApp
//
//  Created by Эван Крошкин on 2.09.22.
//

import UIKit
import SnapKit

class MusicViewController: UIViewController {
    
    lazy var width = view.frame.size.width
    lazy var cellItemHeight: CGFloat = width * 0.75
    lazy var cellItemWidth: CGFloat = width * 0.8
    lazy var cellContentInset: CGFloat = width * 0.1
    lazy var cellSpacing: CGFloat = (width - cellItemWidth) / 2

    private lazy var musicView = MusicView()
    
    private lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = cellSpacing
        layout.itemSize = CGSize(width: cellItemWidth,
                                 height: cellItemHeight)
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets(top: 0, left: cellContentInset,
                                                   bottom: 0, right: cellContentInset)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(MusicCollectionViewCell.self,
                                forCellWithReuseIdentifier: MusicCollectionViewCell.identifier)
        collectionView.backgroundColor = UIColor(red: 29/255,
                                                 green: 23/255,
                                                 blue: 38/255,
                                                 alpha: 1)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    var presenter: MainPresenterProtocol?
    var currentIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    private func setupLayout() {
        view.backgroundColor = UIColor(red: 29/255,
                                       green: 23/255,
                                       blue: 38/255,
                                       alpha: 1)
        
        [musicView, collectionView].forEach({ view.addSubview($0)})
        
        let heightCollectionView = cellItemHeight + CGFloat(20)

        collectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(100)
            make.height.equalTo(heightCollectionView)
        }
        
        musicView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(collectionView.snp.bottom).offset(72)
            make.bottom.equalToSuperview()
        }
    }
}

extension MusicViewController: MusicViewProtocol {
    func changeCellPosition(velocity: CGPoint,
                                    targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        guard let data = presenter?.getSongs() else { return }
        let currentPageWidth = cellItemWidth + cellContentInset - cellSpacing
        var newIndex = currentIndex
        var newCellWidth: CGFloat = 0
        collectionView.reloadItems(at: [IndexPath(row: currentIndex, section: 0)])
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
        let xPoint = CGFloat(newIndex - 1) * newCellWidth + currentPageWidth
        targetContentOffset.pointee = CGPoint (x: xPoint,
                                               y: 0)
    }
    
    func reloadDataCell(index: Int) {
        guard presenter?.getSongs().count != nil,
                let data = presenter?.getSongs()[index] else {
            musicView.songNameLabel.text = ""
            musicView.musicanNameLabel.text = ""
            return
        }
        
        presenter?.prepareToPlay(index: index)
        musicView.songNameLabel.text = data.name
        musicView.musicanNameLabel.text = data.singer
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

