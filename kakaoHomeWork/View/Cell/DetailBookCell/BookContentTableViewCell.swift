//
//  BookContentTableViewCell.swift
//  kakaoHomeWork
//
//  Created by 노영재 on 2022/07/15.
//

import UIKit

class BookContentTableViewCell: UITableViewCell {

    static let resueidentifier = "BookContentTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setContent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: set Label
    let labelContent : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.text = ""
        label.font = UIFont(name: Constant.fontAppleSDGothicNeoLight, size: 15)
        return label
    }()
    
    func setContent() {
        contentView.addSubview(labelContent)
        labelContent.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(10)
            make.trailing.equalTo(contentView).offset(-25)
            make.leading.equalTo(contentView).offset(25)
            make.bottom.equalTo(contentView).offset(-10)
        }
    }
}
