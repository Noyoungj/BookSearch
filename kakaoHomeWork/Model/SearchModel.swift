//
//  SearchModel.swift
//  kakaoHomeWork
//
//  Created by 노영재 on 2022/07/12.
//

import Foundation

struct SearchModel : Decodable {
    let total : String?
    let page : String?
    let books : [BooksModel]?
}

struct BooksModel : Decodable {
    let title : String?
    let subtitle : String?
    let image : String?
    let price : String?
    let url : String?
    let isbn13 : String?
}
