//
//  ViewController.swift
//  MusicListApp
//
//  Created by Эван Крошкин on 2.09.22.
//

import UIKit
import SnapKit

class MusicViewController: UIViewController, MusicViewProtocol {
    
    private var musicView = MusicView()
    
    private let collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 340,
                                 height: 310)
        layout.minimumLineSpacing = 20
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20,
                                                   bottom: 0, right: 20)
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
         
        collectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(100)
            make.height.equalTo(310)
        }
        
        musicView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(collectionView.snp.bottom).offset(72)
            make.bottom.equalToSuperview()
        }
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
}

