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
        label.textAlignment = .center
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
        
        [songNameLabel].forEach({view.addSubview($0)})
        
        songNameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-22)
            make.top.equalToSuperview().offset(482)
        }
        
    }
    
    private func setupSongLabelGradienLayer() {
        songLabelGradienLayer.frame = songNameLabel.bounds
        songNameLabel.layer.addSublayer(songLabelGradienLayer)
    }


}

