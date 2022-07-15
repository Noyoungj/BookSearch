//
//  SearchViewController.swift
//  kakaoHomeWork
//
//  Created by 노영재 on 2022/07/09.
//

import UIKit
import Kingfisher

class SearchViewController: BaseViewController {

    let viewModel = SearchViewModel()
    var arrayBooks : [BooksModel] = []
    
    var isPaging : Bool = false
    var hasNextPage : Bool = false
    var index : Int = 1
    var totalSearchBook : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Loading....
        self.showIndicator()
        
        self.dismissKeyboardWhenTappedAround()
        
        setTextField()
        setCollectionView()
        setViewNoBook()
        
        viewModel.apiNewBook { result in
            self.arrayBooks = result
            
            self.carouselCollectionViewSearch.reloadData()
            self.dismissIndicator()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Search Book"
    }
    
    
    //MARK: Paging Method
    func paging() {
        var datas: [BooksModel] = []
        
        self.index += 1
        
        viewModel.apiSearchBook(self.textFieldSearch.text ?? "", index) { result in
            datas = result.books ?? []
        }
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.arrayBooks.append(contentsOf: datas)
            
            self.hasNextPage = self.index >= self.totalSearchBook ? false : true
            self.isPaging = false
            
            self.carouselCollectionViewSearch.reloadData()
        }
    }

    //MARK: Set Search TextField
    let viewTextField : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor(hex: 0xdfe5ed).cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    let textFieldSearch : CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "Search Books"
        textField.addLeftImage(image: UIImage(systemName: "magnifyingglass") ?? UIImage())
        textField.clearButtonMode = .whileEditing
        return textField
    }()
    
    func setTextField() {
        view.addSubview(viewTextField)
        viewTextField.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.width.equalTo(view).multipliedBy(0.9)
            make.top.equalTo(view).offset(150)
            make.height.equalTo(50)
        }
        
        //MARK: Debounce TextField
        textFieldSearch.debounce(delay: 0.4) { text in
            if let text = self.textFieldSearch.text {
                if text == "" {
                    self.viewModel.apiNewBook { result in
                        self.arrayBooks = result
                        self.labelNoBook.alpha = 0
                        self.carouselCollectionViewSearch.reloadData()
                    }
                } else {
                    self.viewModel.apiSearchBook(text, self.index) { result in
                        self.arrayBooks = result.books ?? []
                        let total = Int(result.total ?? "") ?? 0

                        self.totalSearchBook = total
                        if self.index < total {
                            self.hasNextPage = true
                        }

                        
                        if self.arrayBooks.isEmpty {
                            self.labelNoBook.alpha = 1
                        } else {
                            self.labelNoBook.alpha = 0
                        }
                        self.carouselCollectionViewSearch.reloadData()
                    }
                }
            } else {
                self.viewModel.apiNewBook { result in
                    self.arrayBooks = result
                    self.labelNoBook.alpha = 0
                    self.carouselCollectionViewSearch.reloadData()
                }
            }
        }
        viewTextField.addSubview(textFieldSearch)
        textFieldSearch.snp.makeConstraints { make in
            make.center.equalTo(viewTextField)
            make.width.equalTo(viewTextField).multipliedBy(0.9)
        }
    }
    
    //MARK: Set No Book View
    let labelNoBook : UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.numberOfLines = 0
        label.font = UIFont(name: Constant.fontAppleSDGothicNeoBold, size: 18)
        label.textAlignment = .center
        label.alpha = 0
        label.layer.zPosition = 499
        label.text = "The Book could not be found.\nSorry!"
        return label
    }()
    func setViewNoBook() {
        view.addSubview(labelNoBook)
        labelNoBook.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view).offset(-70)
        }
    }
    //MARK: Set CollectionView
    let carouselCollectionViewSearch : UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 13
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    func setCollectionView() {
        carouselCollectionViewSearch.delegate = self
        carouselCollectionViewSearch.dataSource = self
        carouselCollectionViewSearch.register(IndicatorCollectionViewCell.self, forCellWithReuseIdentifier: IndicatorCollectionViewCell.identifier)
        carouselCollectionViewSearch.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.identifier)
        view.addSubview(carouselCollectionViewSearch)
        carouselCollectionViewSearch.snp.makeConstraints { make in
            make.bottom.trailing.leading.equalTo(view)
            make.top.equalTo(viewTextField.snp.bottom).offset(8)
        }
    }
}

//MARK: set CollectionView
extension SearchViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return arrayBooks.count
        } else if section == 1 && isPaging && hasNextPage {
            return 1
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.identifier, for: indexPath) as? SearchCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            
            cell.layer.shadowColor = UIColor.black.cgColor
            cell.layer.shadowOpacity = 0.3
            cell.layer.shadowOffset = CGSize(width: 2, height: 1)
            
            cell.viewContent.layer.cornerRadius = 15
            cell.viewContent.clipsToBounds = true
            
            if let urlString = arrayBooks[indexPath.row].image {
                let url = URL(string: urlString)
                cell.imageViewBook.kf.indicatorType = .activity
                cell.imageViewBook.kf.setImage(with: url)
            } else {
                
            }
            cell.labelBookName.text = arrayBooks[indexPath.row].title
            cell.labelBookPrice.text = arrayBooks[indexPath.row].price
            cell.labelBookSubName.text = arrayBooks[indexPath.row].subtitle
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IndicatorCollectionViewCell.identifier, for: indexPath) as? IndicatorCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.start()
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
   
        if indexPath.section == 0 {
            return CGSize(width: UIScreen.main.bounds.width * 0.9, height: 91)
        } else {
            return CGSize(width: UIScreen.main.bounds.width, height: 70)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let NextVC = DetailBookViewController()
        NextVC.bookNumber = arrayBooks[indexPath.row].isbn13
        self.navigationController?.pushViewController(NextVC, animated: false)
    }

}

//MARK: Paging 처리를 위한 기능
extension SearchViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
                let contentHeight = scrollView.contentSize.height
                let height = scrollView.frame.height
                
                // 스크롤이 테이블 뷰 Offset의 끝에 가게 되면 다음 페이지를 호출
                if offsetY > (contentHeight - height) {
                    if isPaging == false && hasNextPage {
                        beginPaging()
                    }
                }
    }
    
    func beginPaging() {
            isPaging = true // 현재 페이징이 진행 되는 것을 표시
            // Section 1을 reload하여 로딩 셀을 보여줌 (페이징 진행 중인 것을 확인할 수 있도록)
            DispatchQueue.main.async {
                self.carouselCollectionViewSearch.reloadSections(IndexSet(integer: 1))
            }
            
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.paging()
        }
    }
}


