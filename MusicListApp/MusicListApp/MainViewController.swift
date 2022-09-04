//
//  ViewController.swift
//  MusicListApp
//
//  Created by Эван Крошкин on 2.09.22.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    private lazy var songNameLabel: UILabel = {
        let label = UILabel()
        label.text = "nameSowrwerwerwererwe ewr rwe r w re ng"
        label.textAlignment = .left
        label.textColor = .white
        label.layer.masksToBounds = true
        label.font = .systemFont(ofSize: 20,
                                 weight: .semibold)
        return label
    }()
    
    private lazy var songLabelGradienLayer: CAGradientLayer = {
        let gradienLayer = CAGradientLayer()
        gradienLayer.colors = [UIColor.clear.cgColor,
                               UIColor.black.cgColor]
        gradienLayer.startPoint = CGPoint(x: 0.5,
                                          y: 0.5)
        gradienLayer.endPoint = CGPoint(x: 1.0,
                                        y: 0.5)
        return gradienLayer
    }()
    
    private lazy var musicanNameLabel: UILabel = {
        let label = UILabel()
        label.text = "nameSowrwerwerwererwe ewr rwe r w re ng"
        label.textAlignment = .left
        label.textColor = .white
        label.layer.masksToBounds = true
        label.font = .systemFont(ofSize: 14,
                                 weight: .light)
        return label
    }()
    
    private lazy var musicSlider: UISlider = {
        let slider = UISlider()
        return slider
    }()
    
    private lazy var playMusicButton: UIButton = {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupSongLabelGradienLayer()
    }
    
    private func setupLayout() {
        view.backgroundColor = UIColor(red: 29/255,
                                       green: 23/255,
                                       blue: 38/255,
                                       alpha: 1)
        
        [songNameLabel, musicanNameLabel,
         musicSlider, playMusicButton, backwardMusicButton,
        nextMusicButton].forEach({view.addSubview($0)})
        
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

