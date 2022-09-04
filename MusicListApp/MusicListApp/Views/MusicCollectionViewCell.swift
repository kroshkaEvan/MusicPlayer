//
//  MusicCollectionViewCell.swift
//  MusicListApp
//
//  Created by Эван Крошкин on 4.09.22.
//

import UIKit

class MusicCollectionViewCell: UICollectionViewCell {
    static let identifier = "MusicCollectionViewCell"
    
    private lazy var transparentView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.opacity = 0.1
        return view
    }()
    
    private lazy var borderView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.white.cgColor
        return view
    }()
    
    // MARK: - Public properties
    
    var songImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCellLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setupCellLayout() {
        [transparentView, borderView,
         songImageView].forEach( {addSubview($0)} )
        
        songImageView.snp.makeConstraints({ make in
            make.centerX.equalToSuperview()
            make.width.equalTo(310)
            make.height.equalTo(310)
        })
        
        transparentView.snp.makeConstraints({ make in
            make.top.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        })
        
        borderView.snp.makeConstraints({ make in
            make.top.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        })
    }
}
