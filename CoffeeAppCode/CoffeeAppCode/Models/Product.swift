//
//  Product.swift
//  CoffeeAppCode
//
//  Created by 김현석 on 2022/08/26.
//

import UIKit

//MARK: - 데이터 모델
// 실제 API에서 받게 되는 정보
struct PrdListData: Codable {
    let prdCate: String
    let prdCateSub: String
    let prdList: [Product]

    enum CodingKeys: String, CodingKey {
        case prdCate = "PRD_CATE"
        case prdCateSub = "PRD_CATE_SUB"
        case prdList = "PRD_LIST"
    }
}


// 실제 우리가 사용하게될 제품(Product) 모델 구조체
// (서버에서 가져온 데이터만 표시해주면 되기 때문에 일반적으로 구조체로 만듦)
// MARK: - PrdList
struct Product: Codable {
    let prdSeq: String
    let prdNameKr: String
    let prdNameEn: String
    let prdNotice: String
    let prdPrice: Int
    let prdImg: String

    enum CodingKeys: String, CodingKey {
        case prdSeq = "PRD_SEQ"
        case prdNameKr = "PRD_NAME_KR"
        case prdNameEn = "PRD_NAME_EN"
        case prdNotice = "PRD_NOTICE"
        case prdPrice = "PRD_PRICE"
        case prdImg = "PRD_IMG"
    }
    
    // (출시 정보에 대한 날짜를 잘 계산하기 위해서) 계산 속성으로
    // "2011-07-05T12:00:00Z" ===> "yyyy-MM-dd"
//    var releaseDateString: String? {
//        // 서버에서 주는 형태 (ISO규약에 따른 문자열 형태)
//        guard let isoDate = ISO8601DateFormatter().date(from: releaseDate ?? "") else {
//            return ""
//        }
//        let myFormatter = DateFormatter()
//        myFormatter.dateFormat = "yyyy-MM-dd"
//        let dateString = myFormatter.string(from: isoDate)
//        return dateString
//    }
    
    
}

