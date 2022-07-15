//
//  BookDetailModel.swift
//  kakaoHomeWork
//
//  Created by 노영재 on 2022/07/13.
//

import Foundation

struct BookDetailModel : Decodable {
    var error : String?
    var title : String?
    var subtitle : String?
    var authors : String?
    var publisher : String?
    var pages: String?
    var years: String?
    var rating : String?
    var desc: String?
    var price : String?
    var isbn13 : String?
    var image : String?
    var url : String?
}
