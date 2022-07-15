//
//  BookDetailViewModel.swift
//  kakaoHomeWork
//
//  Created by 노영재 on 2022/07/13.
//

import Alamofire

class BookDetailViewModel {
    func apiBookDetail(_ isbn13: String, completionHander: @escaping (_ result : BookDetailModel) -> ()) {
        AF.request("https://api.itbook.store/1.0/books/\(isbn13)", method: .get, parameters: nil).validate().responseDecodable(of: BookDetailModel.self) { response in
            switch response.result {
            case .success(let result):
                completionHander(result)
            case .failure(let error):
                print(error)
            }
        }
    }
}
