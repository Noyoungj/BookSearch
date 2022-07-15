//
//  SearchViewModel.swift
//  kakaoHomeWork
//
//  Created by 노영재 on 2022/07/12.
//

import Alamofire
class SearchViewModel {
    func apiSearchBook(_ searchText: String, _ page : Int, completionHander: @escaping (_ result : SearchModel) -> ()) {
        AF.request("https://api.itbook.store/1.0/search/\(searchText)/\(page)", method: .get, parameters: nil).validate().responseDecodable(of: SearchModel.self) { response in
            switch response.result {
            case .success(let result):
                completionHander(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func apiNewBook(completionHander: @escaping (_ result: Array<BooksModel>) ->()) {
        AF.request("https://api.itbook.store/1.0/new", method: .get, parameters: nil).validate().responseDecodable(of: NewModel.self) { response in
            switch response.result {
            case .success(let result):
                completionHander(result.books ?? [])
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

