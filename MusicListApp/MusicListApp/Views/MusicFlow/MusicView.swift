//
//  MainView.swift
//  MusicListApp
//
//  Created by Эван Крошкин on 4.09.22.
//

import UIKit
import SnapKit

class MusicView: UIView {
        
    private lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = cellSpacing
        layout.itemSize = CGSize(width: cellItemWidth,
                                 height: cellItemHeight)
        return layout
    }()
    
    lazy var width: CGFloat = UIScreen.main.bounds.width
    lazy var height: CGFloat = UIScreen.main.bounds.height
    lazy var cellItemHeight: CGFloat = width * 0.75
    lazy var cellItemWidth: CGFloat = width * 0.8
    lazy var cellContentInset: CGFloat = width * 0.1
    lazy var cellSpacing: CGFloat = (width - cellItemWidth) / 2
    
    //MARK: - Views

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets(top: 0,
                                                   left: cellContentInset,
                                                   bottom: 0,
                                                   right: cellContentInset)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(MusicCollectionViewCell.self,
                                forCellWithReuseIdentifier: MusicCollectionViewCell.identifier)
        collectionView.backgroundColor = Color.darkPurpleAppColor
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
                               Color.darkPurpleAppColor.cgColor]
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
        slider.maximumTrackTintColor = Color.lightPurpleAppColorAlpha
        slider.thumbTintColor = Color.lightPurpleAppColorAlpha
        slider.tintColor = Color.lightPurpleAppColor
        slider.isUserInteractionEnabled = false
        return slider
    }()
    
    lazy var currentTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.textAlignment = .left
        label.textColor = .lightGray
        label.layer.masksToBounds = true
        label.font = .systemFont(ofSize: 12,
                                 weight: .light)
        return label
    }()
    
    lazy var remaningTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.textAlignment = .right
        label.textColor = .lightGray
        label.layer.masksToBounds = true
        label.font = .systemFont(ofSize: 12,
                                 weight: .light)
        return label
    }()
    
    lazy var playMusicButton: UIButton = {
        let button = UIButton()
        let configImage = UIImage.SymbolConfiguration(pointSize: 44)
        button.setImage(UIImage(systemName: "play.fill",
                                withConfiguration: configImage),
                        for: .normal)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 15
        button.layer.shadowOpacity = 5
        button.layer.cornerRadius = 40
        button.tintColor = .white
        button.backgroundColor = Color.darkPurpleAppColor
        return button
    }()
    
    lazy var nextMusicButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "forward.end"),
                        for: .normal)
        button.backgroundColor = .clear
        button.tintColor = .white
        return button
    }()
    
    lazy var backwardMusicButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "backward.end"),
                        for: .normal)
        button.backgroundColor = .clear
        button.tintColor = .white
        return button
    }()
    
    lazy var buttonsStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [backwardMusicButton,
                                                  playMusicButton,
                                                  nextMusicButton])
        view.spacing = 25
        view.axis = .horizontal
        return view
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
         musicSlider, remaningTimeLabel,
         currentTimeLabel, buttonsStackView].forEach({ addSubview($0)})
        
        let heightCollectionView: CGFloat = cellItemHeight + CGFloat(20)
        let topOffsetCollectionView: CGFloat = height * 0.1
        let topOffsetSongNameLabel: CGFloat = height * 0.07
        let topOffsetButtons: CGFloat = height * 0.075
        let topOffsetSlider: CGFloat = height * 0.042

        
        collectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(topOffsetCollectionView)
            make.height.equalTo(heightCollectionView)
        }
                
        songNameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-50)
            make.top.equalTo(collectionView.snp.bottom).offset(topOffsetSongNameLabel)
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
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(musicanNameLabel.snp.bottom).offset(topOffsetSlider)
        }
        
        currentTimeLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(musicSlider.snp.bottom).offset(8)
            make.height.equalTo(20)
            make.width.equalTo(40)
        }
        
        remaningTimeLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(musicSlider.snp.bottom).offset(8)
            make.height.equalTo(20)
            make.width.equalTo(40)
        }
        
        buttonsStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(80)
            make.top.equalTo(musicSlider.snp.bottom).offset(topOffsetButtons)
        }
        
        playMusicButton.snp.makeConstraints { make in
            make.height.equalTo(80)
            make.width.equalTo(80)
        }
        
    }
    
    private func setupSongLabelGradienLayer() {
        songLabelGradienLayer.frame = songNameLabel.bounds
        songNameLabel.layer.addSublayer(songLabelGradienLayer)
    }
}

// MARK: - Constants

extension MusicView {
    
    enum Color {
        static let lightPurpleAppColor = UIColor(red: 130/255,
                                                 green: 87/255,
                                                 blue: 231/255,
                                                 alpha: 1)
        static let lightPurpleAppColorAlpha = UIColor(red: 130/255,
                                                      green: 87/255,
                                                      blue: 231/255,
                                                      alpha: 0.3)
        static let darkPurpleAppColor = UIColor(red: 29/255,
                                                green: 23/255,
                                                blue: 38/255,
                                                alpha: 1)
    }
}
