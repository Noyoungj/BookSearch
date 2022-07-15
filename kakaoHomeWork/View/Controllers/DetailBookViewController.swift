//
//  DetailBookViewController.swift
//  kakaoHomeWork
//
//  Created by 노영재 on 2022/07/13.
//

import UIKit
import Kingfisher

class DetailBookViewController: BaseViewController {
    var bookNumber : String?
    var result : BookDetailModel?
    
    let viewModel = BookDetailViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: Link DataManager
        if let bookNumber = bookNumber {
            viewModel.apiBookDetail(bookNumber) { result in
                self.result = result
                self.tableViewContent.reloadData()
                print(self.result)
                self.labelBookName.text = result.title
                
                let stringAuthor = "저자 \(result.authors ?? "")"
                let attributeAuthor = stringAuthor.attributeStringFontAndColor(stringAuthor, Constant.fontAppleSDGothicNeoLight, 10, 0, 2, .lightGray)
                self.labelBookAuthor.attributedText = attributeAuthor

                let stringPublisher = "출판사 \(result.publisher ?? "")"
                let attributePublisher = stringPublisher.attributeStringFontAndColor(stringPublisher, Constant.fontAppleSDGothicNeoLight, 10, 0, 3, UIColor.lightGray)
                self.labelBookPublisher.attributedText = attributePublisher
                
                self.labelBookPrice.text = result.price ?? ""
            }
        }
        setNavigationBar()
        setTableView()
        setBookInfo()
    }

    //MARK: set NavigationBar
    func setNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .gray
        self.navigationController?.navigationBar.backgroundColor = .white
        self.title = "책 정보"
    }
    
    
   
    //MARK: set ScrollView
    let tableViewContent : UITableView = {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    func setTableView() {
        tableViewContent.delegate = self
        tableViewContent.dataSource = self
        tableViewContent.estimatedRowHeight = 400
        tableViewContent.rowHeight = UITableView.automaticDimension
        tableViewContent.register(PurchaseBookTableViewCell.self, forCellReuseIdentifier: PurchaseBookTableViewCell.resueidentifier)
        tableViewContent.register(BookContentTableViewCell.self, forCellReuseIdentifier: BookContentTableViewCell.resueidentifier)
        tableViewContent.register(BookImageTableViewCell.self, forCellReuseIdentifier: BookImageTableViewCell.resueidentifier)
        view.addSubview(tableViewContent)
        tableViewContent.snp.makeConstraints { make in
            make.top.equalTo(view).offset(100)
            make.leading.trailing.bottom.equalTo(view)
        }
    }

    //MARK: set Bookinfo
    
    let viewBookInfo : UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.zPosition = 499
        view.backgroundColor = .white
        return view
    }()
    //MARK: 책 이름
    let labelBookName : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 15)
        label.numberOfLines = 2
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
        label.font = UIFont(name: Constant.fontAppleSDGothicNeoLight, size: 13)
        return label
    }()
    
    //MARK: 출판사
    let labelBookPublisher : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 10)
        return label
    }()
    
    //MARK: 저자
    let labelBookAuthor : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 10)
        return label
    }()
    
    func setBookInfo() {
        
        view.addSubview(viewBookInfo)
        viewBookInfo.frame = CGRect(x: view.bounds.width * 0.1, y: 350 - 50, width: view.bounds.width * 0.8, height: 100)
        
        viewBookInfo.addSubview(labelBookName)
        labelBookName.snp.makeConstraints { make in
            make.top.equalTo(viewBookInfo).offset(10)
            make.leading.equalTo(viewBookInfo).offset(10)
            make.trailing.equalTo(viewBookInfo).offset(-10)
        }
        
        viewBookInfo.addSubview(labelBookPrice)
        labelBookPrice.snp.makeConstraints { make in
            make.bottom.trailing.equalTo(viewBookInfo).offset(-10)
            make.width.equalTo(50)
        }
        
        viewBookInfo.addSubview(labelBookAuthor)
        labelBookAuthor.snp.makeConstraints { make in
            make.leading.equalTo(labelBookName)
            make.bottom.equalTo(viewBookInfo).offset(-10)
            make.trailing.equalTo(labelBookPrice.snp.leading).offset(-8)
        }
        
        viewBookInfo.addSubview(labelBookPublisher)
        labelBookPublisher.snp.makeConstraints { make in
            make.leading.equalTo(labelBookName)
            make.bottom.equalTo(labelBookAuthor.snp.top).offset(-5)
            make.trailing.equalTo(labelBookPrice.snp.leading).offset(-8)
        }
        
       
    }
}

//MARK: Scroll View 기능들
extension DetailBookViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let nowYPosition = scrollView.contentOffset.y
        
        let heightBookInfo = 300 - (nowYPosition)
        if nowYPosition > 200 {
            viewBookInfo.frame = CGRect(x: 0, y: 100, width: view.bounds.width, height: 100)
            setBookInfolayer(false)
        } else {
            viewBookInfo.frame = CGRect(x: view.bounds.width * 0.1, y: heightBookInfo, width: view.bounds.width * 0.8, height: 100)
            setBookInfolayer(true)
        }
    }
    
    func setBookInfolayer(_ bool : Bool) {
        if bool {
            viewBookInfo.layer.cornerRadius = 10
            viewBookInfo.layer.shadowOpacity = 0.2
        } else {
            viewBookInfo.layer.cornerRadius = 0
            viewBookInfo.layer.shadowOpacity = 0
        }
    }
}

//MARK: Set TableView
extension DetailBookViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BookImageTableViewCell.resueidentifier, for: indexPath) as? BookImageTableViewCell else {
                return UITableViewCell()
            }
            if let urlString = result?.image {
               let url = URL(string: urlString)
                cell.imageViewBook.kf.indicatorType = .activity
                cell.imageViewBook.kf.setImage(with: url)
            } else {
                
            }
            
            cell.selectionStyle = .none
            return cell
        } else if indexPath.row == 5 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PurchaseBookTableViewCell.resueidentifier, for: indexPath) as? PurchaseBookTableViewCell else {
                return UITableViewCell()
            }
            cell.buttonPurchase.setTitle(self.result?.url ?? "", for: .normal)
            cell.buttonPurchase.addTarget(self, action: #selector(actionGoSafari), for: .touchUpInside)
            return cell
            
        }
        else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BookContentTableViewCell.resueidentifier, for: indexPath) as? BookContentTableViewCell else {
                return UITableViewCell()
            }
            if indexPath.row == 2 {
                if let string = self.result?.pages {
                    let pageString = "Pages \(string)p"
                    let attributeString = pageString.attributeStringFontAndColor(pageString, Constant.fontAppleSDGothicNeoBold, 15, 0, 5, .black)
                    cell.labelContent.attributedText = attributeString
                }
            } else if indexPath.row == 3 {
                if let string = self.result?.years {
                    let yearsString = "Years \(string) year"
                    let attributeString = yearsString.attributeStringFontAndColor(yearsString, Constant.fontAppleSDGothicNeoBold, 15, 0, 5, .black)
                    cell.labelContent.attributedText = attributeString
                } else {
                    cell.labelContent.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 15)
                    cell.labelContent.text = ""
                }
            } else if indexPath.row == 4 {
                if let string = self.result?.desc {
                    let attributeString = NSMutableAttributedString(string: string)
                    let paragraphStyle = NSMutableParagraphStyle()
                    paragraphStyle.lineSpacing = 15
                    attributeString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: string.count))
                    cell.labelContent.attributedText = attributeString
                }
            }
            
            cell.selectionStyle = .none
            return cell
        }
    }
    
    //MARK: Safari Link
    @objc func actionGoSafari() {
        if let string = result?.url {
            if let url = URL(string: string) {
                UIApplication.shared.open(url, options: [:])
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 200
        } else if indexPath.row == 1 {
            return 125
        } else {
            return UITableView.automaticDimension
        }
    }
}
