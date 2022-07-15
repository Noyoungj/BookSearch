//
//  SearchCollectionViewCell.swift
//  kakaoHomeWork
//
//  Created by 노영재 on 2022/07/12.
//

import UIKit

class SearchCollectionViewCell: UICollectionViewCell {
    static let identifier = "SearchCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setContent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: 책 사진
    let imageViewBook : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    //MARK: 책 이름
    let labelBookName : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 13)
        return label
    }()
    //MARK: 책 서브 타이틀
    let labelBookSubName : UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont(name: Constant.fontAppleSDGothicNeoLight, size: 10)
        return label
    }()
    
    //MARK: 책 가격
    let labelBookPrice : UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont(name: Constant.fontAppleSDGothicNeoLight, size: 18)
        label.textAlignment = .right
        return label
    }()

    //MARK: Cell 구성
    let viewContent : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    func setContent() {
        contentView.addSubview(viewContent)
        viewContent.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
        viewContent.addSubview(imageViewBook)
        imageViewBook.snp.makeConstraints { make in
            make.leading.equalTo(viewContent).offset(15)
            make.top.equalTo(viewContent).offset(5)
            make.bottom.equalTo(viewContent).offset(-5)
            make.width.equalTo(imageViewBook.snp.height)
        }
        
        viewContent.addSubview(labelBookPrice)
        labelBookPrice.snp.makeConstraints { make in
            make.bottom.equalTo(imageViewBook)
            make.trailing.equalTo(viewContent).offset(-15)
        }
        
        viewContent.addSubview(labelBookName)
        labelBookName.snp.makeConstraints { make in
            make.trailing.equalTo(viewContent.snp.trailing).offset(-12)
            make.leading.equalTo(imageViewBook.snp.trailing).offset(12)
            make.top.equalTo(imageViewBook)
        }
        
        viewContent.addSubview(labelBookSubName)
        labelBookSubName.snp.makeConstraints { make in
            make.top.equalTo(labelBookName.snp.bottom).offset(8)
            make.leading.equalTo(labelBookName)
            make.trailing.equalTo(viewContent.snp.trailing).offset(-12)
        }
        
    }
}
