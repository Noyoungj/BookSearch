//
//  BookImageTableViewCell.swift
//  kakaoHomeWork
//
//  Created by 노영재 on 2022/07/15.
//

import UIKit

class BookImageTableViewCell: UITableViewCell {
    static let resueidentifier = "BookImageTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setContent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let viewContent : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    //MARK: 책 사진
    let imageViewBook : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    func setContent() {
        contentView.addSubview(viewContent)
        viewContent.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
            make.height.equalTo(200)
        }
        
        viewContent.addSubview(imageViewBook)
        imageViewBook.snp.makeConstraints { make in
            make.edges.equalTo(viewContent)
        }
    }
}
