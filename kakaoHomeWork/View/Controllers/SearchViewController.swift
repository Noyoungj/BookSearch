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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setCollectionView()
        
        viewModel.apiNewBook { result in
            self.arrayBooks = result
            self.carouselCollectionViewSearch.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "책 찾기"
    }
    //MARK: Set Navigation Bar
    let searchController = UISearchController(searchResultsController: nil)
    
    func setNavigationBar() {
        self.searchController.searchResultsUpdater = self
        self.navigationItem.searchController = searchController
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
        carouselCollectionViewSearch.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.identifier)
        view.addSubview(carouselCollectionViewSearch)
        carouselCollectionViewSearch.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
    }
}

//MARK: set CollectionView
extension SearchViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayBooks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
   
        return CGSize(width: UIScreen.main.bounds.width * 0.9, height: 91)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let NextVC = DetailBookViewController()
        NextVC.bookNumber = arrayBooks[indexPath.row].isbn13
        self.navigationController?.pushViewController(NextVC, animated: false)
    }

}

//MARK: SearchBar Text Update
extension SearchViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text {
            if text == "" {
                viewModel.apiNewBook { result in
                    self.arrayBooks = result
                    self.carouselCollectionViewSearch.reloadData()
                }
            } else {
                viewModel.apiSearchBook(text) { result in
                    self.arrayBooks = result
                    self.carouselCollectionViewSearch.reloadData()
                }
            }
        } else {
            viewModel.apiNewBook { result in
                self.arrayBooks = result
                self.carouselCollectionViewSearch.reloadData()
            }
        }
    }
}


