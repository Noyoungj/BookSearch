//
//  PurchaseBookTableViewCell.swift
//  kakaoHomeWork
//
//  Created by 노영재 on 2022/07/15.
//

import UIKit

class PurchaseBookTableViewCell: UITableViewCell {
    static let resueidentifier = "PurchaseBookTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setContent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let labelPurchase : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Purchase: "
        label.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 12)
        return label
    }()
    
    let buttonPurchase : UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 12)
        button.setTitleColor(UIColor.gray, for: .normal)
        button.titleLabel?.textAlignment = .left
        return button
    }()
    
    func setContent() {
        contentView.addSubview(labelPurchase)
        labelPurchase.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(20)
            make.leading.equalTo(contentView).offset(25)
            make.bottom.equalTo(contentView).offset(-10)
        }
        
        contentView.addSubview(buttonPurchase)
        buttonPurchase.snp.makeConstraints { make in
            make.leading.equalTo(labelPurchase.snp.trailing).offset(4)
            make.top.bottom.equalTo(labelPurchase)
            make.trailing.lessThanOrEqualTo(contentView).offset(-25)
        }
    }

}
