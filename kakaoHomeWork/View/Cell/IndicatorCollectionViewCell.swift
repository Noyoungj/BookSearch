//
//  IndicatorCollectionViewCell.swift
//  kakaoHomeWork
//
//  Created by 노영재 on 2022/07/16.
//

import UIKit

class IndicatorCollectionViewCell: UICollectionViewCell {
    static let identifier = "IndicatorCollectionViewCell"
    
    let activityIndicatorView = UIActivityIndicatorView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(activityIndicatorView)
        activityIndicatorView.snp.makeConstraints { make in
            make.center.equalTo(contentView)
        }
    }
    
    func start() {
        activityIndicatorView.startAnimating()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
