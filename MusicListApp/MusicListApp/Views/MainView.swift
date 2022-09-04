//
//  MainView.swift
//  MusicListApp
//
//  Created by Эван Крошкин on 4.09.22.
//

import UIKit
import SnapKit

class MusicView: UIView {
    
    // MARK: - Properties
    
    weak var viewController: MusicViewController?
    
    //MARK: - Views
    
    private let collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 341,
                                 height: 310)
        layout.minimumLineSpacing = 20
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 32,
                                                   bottom: 0, right: 32)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(MusicCollectionViewCell.self,
                                forCellWithReuseIdentifier: MusicCollectionViewCell.identifier)
        return collectionView
    }()
    
    lazy var songNameLabel: UILabel = {
        let label = UILabel()
        label.text = "songName"
        label.textAlignment = .left
        label.textColor = .white
        label.font = .systemFont(ofSize: 20,
                                 weight: .semibold)
        return label
    }()
    
    lazy var songLabelGradienLayer: CAGradientLayer = {
        let gradienLayer = CAGradientLayer()
        gradienLayer.colors = [UIColor.clear.cgColor,
                               UIColor.black.cgColor]
        gradienLayer.startPoint = CGPoint(x: 0.5,
                                          y: 0.5)
        gradienLayer.endPoint = CGPoint(x: 1.0,
                                        y: 0.5)
        return gradienLayer
    }()
    
    lazy var musicanNameLabel: UILabel = {
        let label = UILabel()
        label.text = "musicanName"
        label.textAlignment = .left
        label.textColor = .white
        label.layer.masksToBounds = true
        label.font = .systemFont(ofSize: 14,
                                 weight: .light)
        return label
    }()
    
    lazy var musicSlider: UISlider = {
        let slider = UISlider()
        slider.thumbTintColor = UIColor(red: 130/255,
                                        green: 87/255,
                                        blue: 231/255,
                                        alpha: 1)
        slider.tintColor = UIColor(red: 130/255,
                                   green: 87/255,
                                   blue: 231/255,
                                   alpha: 1)
        return slider
    }()
    
    lazy var playMusicButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "play"),
                        for: .normal)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 15
        button.layer.shadowOpacity = 5
        button.layer.cornerRadius = 40
        button.tintColor = .white
        button.backgroundColor = UIColor(red: 29/255,
                                         green: 23/255,
                                         blue: 38/255,
                                         alpha: 1)
        return button
    }()
    
    private lazy var nextMusicButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "forward.end"),
                        for: .normal)
        button.backgroundColor = .clear
        button.tintColor = .white
        return button
    }()
    
    private lazy var backwardMusicButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "backward.end"),
                        for: .normal)
        button.backgroundColor = .clear
        button.tintColor = .white
        return button
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    override func layoutSubviews() {
        setupSongLabelGradienLayer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        backgroundColor = UIColor(red: 29/255,
                                  green: 23/255,
                                  blue: 38/255,
                                  alpha: 1)
        
        [collectionView, songNameLabel, musicanNameLabel,
         musicSlider, playMusicButton, backwardMusicButton,
        nextMusicButton].forEach({ addSubview($0)})
        
        collectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(100)
            make.height.equalTo(310)
        }
        
        songNameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-22)
            make.top.equalToSuperview().offset(482)
            make.height.equalTo(20)
        }
        
        musicanNameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-22)
            make.top.equalTo(songNameLabel.snp.bottom).offset(5)
            make.height.equalTo(20)
        }
        
        musicSlider.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-22)
            make.top.equalTo(musicanNameLabel.snp.bottom).offset(42)
        }
        
        playMusicButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(80)
            make.width.equalTo(80)
            make.top.equalTo(musicSlider.snp.bottom).offset(78)
        }
        
        nextMusicButton.snp.makeConstraints { make in
            make.leading.equalTo(playMusicButton.snp.trailing).offset(10)
            make.height.equalTo(45)
            make.width.equalTo(45)
            make.centerY.equalTo(playMusicButton.snp.centerY)
        }
        
        backwardMusicButton.snp.makeConstraints { make in
            make.trailing.equalTo(playMusicButton.snp.leading).offset(-10)
            make.height.equalTo(45)
            make.width.equalTo(45)
            make.centerY.equalTo(playMusicButton.snp.centerY)
        }
        
    }
    
    private func setupSongLabelGradienLayer() {
        songLabelGradienLayer.frame = songNameLabel.bounds
        songNameLabel.layer.addSublayer(songLabelGradienLayer)
    }
}
