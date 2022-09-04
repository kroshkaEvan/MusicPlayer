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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func setupView() {
        view = MusicView()
        musicView?.collectionView.dataSource = self
        musicView?.collectionView.delegate = self
    }
}

extension MusicViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MusicCollectionViewCell.identifier,
                                                      for: indexPath)
        if let cell = cell as? MusicCollectionViewCell {
            cell.songImageView.image = UIImage(named: "mothToAFlame")
        }
        return cell
    }
}

